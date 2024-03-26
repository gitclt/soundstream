import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_stream_flutter_app/app/api/api.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/toast.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';
import 'package:sound_stream_flutter_app/app/service/sessio.dart';
import 'package:sound_stream_flutter_app/common_widgets/popup/dialog_helper.dart';
import 'package:sound_stream_flutter_app/constrains/service/location.dart';
import 'package:intl/intl.dart';

class HomeTripController extends GetxController {
  var isLoading = false.obs;
  var isCheckin = false.obs;
  var isCheckOut = false.obs;
  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? checkin = prefs.getString('checkin');
    if (checkin != null && checkin == "true") {
      isCheckin.value = true;
      Session.isCheckin = true;
    }
    super.onInit();
  }

  final List<String> option = [
    'All',
    'Speeches',
    ' Songs',
  ];
  String place = '';
  String date = '';
  String time = '';
  String locality = '';
  DateTime datetime = DateTime.now();
  String crlatitude = '';
  String crlongitude = '';

  Future<bool> getCurrentPos(Position position) async {
    try {
      crlatitude = position.latitude.toString();
      crlongitude = position.longitude.toString();

      List<Placemark> coordinates = await placemarkFromCoordinates(
          double.parse(crlatitude), double.parse(crlongitude));

      Placemark geoAddress = coordinates.first;
      place = geoAddress.locality!;
      locality = geoAddress.subLocality!;

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> fetchLocation() async {
    DialogHelper.showLoading("Fetching Location ...");
    final location = await determinePosition();
    DialogHelper.hideLoading();
    if (location == null) return;

    final locStatus = await getCurrentPos(location);

    if (!locStatus) return;
    markCheckIn(Session.vehId, Session.locId, dateToFormatted(datetime),
        timeFormatted(datetime), place, crlatitude, crlongitude);
  }

  Future<void> markCheckIn(
    String vehId,
    String locId,
    String date,
    String time,
    String place,
    String lat,
    String longi,
  ) async {
    DialogHelper.showLoading("Please wait while marking Check In...");
    try {
      final response = await ApiProvider()
          .checkInVisit(vehId, locId, date, time, place, lat, longi);
      if (response != null) {
        if (response.success == true) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('checkin', "true");
          prefs.setString('checkin_place', place);
          prefs.setString('checkin_time', time);
          prefs.setString('lat', crlatitude);
          prefs.setString('longi', crlongitude);
          prefs.setString('date', date);
          Session.isCheckin = true;
          Session.place = place;
          Session.time = timeFormatted(datetime);
          Session.date = date;
          Session.lati = lat;
          Session.longi = longi;
          DialogHelper.hideLoading();
          toast("Checkin Sucessfully");
          Get.offAndToNamed(Routes.HOME_START);
        } else {
          DialogHelper.hideLoading();
          toast(response.message);
        }
      } else {
        toast("Checkin Sucessfully");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('checkin', "true");
        prefs.setString('checkin_place', place);
        prefs.setString('checkin_time', time);
        prefs.setString('lat', crlatitude);
        prefs.setString('longi', crlongitude);
        prefs.setString('date', date);
        DialogHelper.hideLoading();
        Session.isCheckin = true;
        Session.place = place;
        Session.time = timeFormatted(datetime);
        Session.date = date;
        Session.lati = lat;
        Session.longi = longi;
        Get.offAndToNamed(Routes.HOME_START);
      }
    } finally {
      DialogHelper.hideLoading();
    }
  }

  dateToFormatted(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }

  timeFormatted(DateTime dateTime) {
    return DateFormat("HH:mm").format(dateTime);
  }

  // void startBackgroundLocationUpdates() {
  //   const Duration interval = Duration(seconds: 10);

  //   // ignore: unused_local_variable
  //   final StreamSubscription<Position> positionStream =
  //       Geolocator.getPositionStream().listen((Position position) {
  //     Timer.periodic(interval, (timer) {
  //       print(
  //           'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
  //     });
  //   });
  // }
}

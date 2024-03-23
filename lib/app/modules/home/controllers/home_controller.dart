import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_stream_flutter_app/app/api/api.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/toast.dart';
import 'package:sound_stream_flutter_app/app/model/checkin_model.dart';
import 'package:sound_stream_flutter_app/app/model/song_model.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';
import 'package:sound_stream_flutter_app/app/service/sessio.dart';
import 'package:sound_stream_flutter_app/common_widgets/popup/dialog_helper.dart';
import 'package:sound_stream_flutter_app/constrains/service/location.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController mainController;
  var selectedIndex = 0.obs;
  var isIndex = 0.obs;
  var isLoading = false.obs;
  var isCheckin = false.obs;
  var isCheckOut = false.obs;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer audioPlayer1 = AudioPlayer();
  List<String> songDataList = [];
  List<String> catDataList = [];
  List<String> candiateSong = [];
  List<CheckInData> checkInDataList = [];
  RxList<SongData> songdata = <SongData>[].obs;
  void selectItem(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? checkin = prefs.getString('checkin');
    if (checkin != null && checkin == "true") {
      isCheckin.value = true;
      Session.isCheckin = true;
    }
    super.onInit();

    mainController = TabController(length: 3, vsync: this);
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

  getSongData() async {
    songDataList.clear();
    catDataList.clear();
    isLoading(true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("audioFilePaths")) {
      songDataList = sharedPreferences.getStringList('audioFilePaths') ?? [];
      catDataList = sharedPreferences.getStringList('audioFilePaths') ?? [];
    }
    getSongDetails();
    isLoading(false);
  }

  String formatDuration(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '${duration.inMinutes >= 60 ? '${duration.inMinutes ~/ 60}:' : ''}$minutes:$seconds';
  }

  void categoryFilter(String catId) {
    songDataList.clear();
    if (catId == "") {
      songDataList.addAll(catDataList);
    } else {
      List<String> names = songdata
          .where((e) => e.categoryId == int.parse(catId))
          .map((e) => e.fileName)
          .toList();
      songDataList.addAll(catDataList
          .where((element) => names.contains(element.split("/").last)));
    }
  }

  getSongDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey("songs")) {
      songdata.clear();
      songdata.value = List<Map<String, dynamic>>.from(
              jsonDecode(sharedPreferences.getString("songs")!))
          .map((x) => SongData.fromJson(x))
          .toList();
      List<String> names = songdata
          .where((e) => e.categoryId == 3)
          .map((e) => e.fileName)
          .toList();
      candiateSong.addAll(catDataList
          .where((element) => names.contains(element.split("/").last)));
    }
  }

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
          String? checkin = prefs.getString('checkin');
          if (checkin != null && checkin == "true") {
            isCheckin.value = true;
            Session.isCheckin = true;
            Session.place = place;
            Session.time = timeFormatted(datetime);
          }
          DialogHelper.hideLoading();
          toast("Checkin Sucessfully");
          Get.toNamed(Routes.HOME_START);
        } else {
          DialogHelper.hideLoading();
        }
      } else {
        toast("Checkin Sucessfully");

        Session.isCheckin = true;
        Session.place = place;
        Session.time = timeFormatted(datetime);
        Get.toNamed(Routes.HOME_START);
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

  Future<void> getCheckIn() async {
    try {
      final response = await ApiProvider()
          .getCheckIn(Session.vehId, dateToFormatted(datetime));
      if (response != null) {
        DialogHelper.showLoading("Fetching Location ...");
        final location = await determinePosition();
        DialogHelper.hideLoading();
        if (location == null) return;

        final locStatus = await getCurrentPos(location);

        if (!locStatus) return;
        String duration = calculateDurationBetween(
            response.data.first.checkInTime, timeFormatted(datetime));
        getCheckOutMarkVisit(response.data.first.id.toString(),
            timeFormatted(datetime), place, crlatitude, crlongitude, duration);
      }
    } finally {}
  }

  String calculateDurationBetween(String startTimeStr, String endTimeStr) {
    List<int> startTimeParts = startTimeStr.split(':').map(int.parse).toList();
    List<int> endTimeParts = endTimeStr.split(':').map(int.parse).toList();
    DateTime startTime = DateTime(
      0,
      1,
      1,
      startTimeParts[0],
      startTimeParts[1],
    );
    DateTime endTime = DateTime(
      0,
      1,
      1,
      endTimeParts[0],
      endTimeParts[1],
    );
    Duration duration = endTime.difference(startTime);
    String formattedDuration =
        '${duration.inHours}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return formattedDuration;
  }

  Future<void> getCheckOutMarkVisit(
    String id,
    String time,
    String place,
    String lat,
    String longi,
    String duration,
  ) async {
    isCheckOut(true);
    try {
      final response = await ApiProvider()
          .checkOutVisit(id, time, place, lat, longi, duration);
      if (response != null) {
        if (response.success == true) {
          toast(response.message);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('checkin', "false");
          String? checkin = prefs.getString('checkin');
          if (checkin != null && checkin == "false") {
            isCheckin.value = false;
            Session.isCheckin = false;
            Session.place = "";
            Session.time = "";
          }
        } else {
          isCheckOut(false);
        }
      }
    } finally {
      isCheckOut(false);
    }
  }
}

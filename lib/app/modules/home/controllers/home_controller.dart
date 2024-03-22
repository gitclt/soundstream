import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_stream_flutter_app/app/model/song_model.dart';
import 'package:sound_stream_flutter_app/common_widgets/popup/dialog_helper.dart';
import 'package:sound_stream_flutter_app/constrains/service/location.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController mainController;
  var selectedIndex = 0.obs;
  var isIndex = 0.obs;
  List<SongData> songDataList = [];

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();

    mainController = TabController(length: 3, vsync: this);
  }

  final List<String> option = [
    'All',
    'Speeches',
    ' Songs',
  ];
    String place = '';
  String locality = '';

  String crlatitude = '';
  String crlongitude = '';

  getSongData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("audioFilePaths")) {
      // songDataList = List<Map<String, dynamic>>.from(
      //         jsonDecode(sharedPreferences.getString("songs")!))
      //     .map((x) => SongData.fromJson(x))
      //     .toList();
      List<String> filePaths =
          sharedPreferences.getStringList('audioFilePaths') ?? [];
      print(filePaths);
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
      //  print(e.toString());
      return false;
    }
  }





    Future<void> fetchLocation(
    // BuildContext context,
    // bool status,
    // String kmDiff,
    // String visitType,
    // String empId,
    // String leadId,
    // String place,
  ) async {
    // itemController.clear();
    // planChecked.value = false;
    // creditChecked.value = false;
    // remarkController.clear();
    DialogHelper.showLoading("Fetching Location ...");
    final location = await determinePosition();
    DialogHelper.hideLoading();
    if (location == null) return;

    final locStatus = await getCurrentPos(location);

    if (!locStatus) return;

  }
}

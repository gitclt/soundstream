import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
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
  var isLoading = false.obs;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer audioPlayer1 = AudioPlayer();
  List<String> songDataList = [];
  List<String> catDataList = [];
  List<String> candiateSong = [];
  RxList<SongData> songdata = <SongData>[].obs;
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
      //  print(e.toString());
      return false;
    }
  }

//  Future<double> getLocation(
//     double lati,
//     double longi,
//   ) async {
//     // if (value != 1) {
//     DialogHelper.showLoading("Fetching Location ...");
//     final location = await determinePosition();
//     DialogHelper.hideLoading();
//     if (location == null) return 0.0;

//     final locStatus = await getCurrentPos(location);

//     if (!locStatus) return 0.0;

//     var distance = checkDistance(
//       lati,
//       longi,
//       double.parse(crlatitude),
//       double.parse(crlongitude),
//     );

//     return distance;
//   }


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

    if (!locStatus)return;
}
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController mainController;
  var selectedIndex = 0.obs;
  var isIndex = 0.obs;
  List<String> songDataList = [];

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

  getSongData() async {
    songDataList.clear();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("audioFilePaths")) {
      // songDataList = List<Map<String, dynamic>>.from(
      //         jsonDecode(sharedPreferences.getString("songs")!))
      //     .map((x) => SongData.fromJson(x))
      //     .toList();
      songDataList = sharedPreferences.getStringList('audioFilePaths') ?? [];
      print(songDataList);
    }
  }
}

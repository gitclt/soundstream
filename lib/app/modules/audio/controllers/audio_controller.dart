import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_stream_flutter_app/app/model/song_model.dart';
import 'package:sound_stream_flutter_app/app/service/audio.dart';

class AudioController extends GetxController with GetTickerProviderStateMixin {
  late TabController mainController;
  AudioPlayerService audioController = AudioPlayerService();
  var selectedIndex = 0.obs;
  var isIndex = 0.obs;
  var isaudioIndex = 0.obs;
  List<String> catDataList = [];
  RxList<SongData> songdata = <SongData>[].obs;
  AudioPlayer audioPlayer = AudioPlayer();
  final arg = Get.arguments[0];
  List<String> songDataList = [];

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    songDataList = Get.arguments[1];
    catDataList = Get.arguments[2];
    isIndex.value = Get.arguments[3];
    super.onInit();
    getSongDetails();
    mainController = TabController(length: 4, vsync: this);
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
    }
  }
}

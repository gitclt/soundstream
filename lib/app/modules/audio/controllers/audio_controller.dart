import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/service/audio.dart';

class AudioController extends GetxController with GetTickerProviderStateMixin {
  late TabController mainController;
     AudioPlayerService audioController = AudioPlayerService();
  var selectedIndex = 0.obs;
  var isIndex = 0.obs;
  var isaudioIndex = 0.obs;
  AudioPlayer audioPlayer = AudioPlayer();
  final arg = Get.arguments[0];
  List<String> songDataList = [];

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    songDataList = Get.arguments[1];
    super.onInit();
    mainController = TabController(length: 3, vsync: this);
  }

  String formatDuration(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '${duration.inMinutes >= 60 ? '${duration.inMinutes ~/ 60}:' : ''}$minutes:$seconds';
  }
}

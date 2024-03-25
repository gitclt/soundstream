import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/controllers/home_controller.dart';
import 'package:sound_stream_flutter_app/app/service/audio.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';

class HomePlayButton extends StatefulWidget {
  const HomePlayButton({super.key});

  @override
  State<HomePlayButton> createState() => _HomePlayButtonState();
}

class _HomePlayButtonState extends State<HomePlayButton> {
  bool isState = false;
  bool isPlaying = false;
  AudioPlayerService audioController = AudioPlayerService();
  // AudioPlayer audioPlayer = AudioPlayer();
  List<String> existingFilePaths = [];
  Duration duartion = Duration.zero;
  Duration position = Duration.zero;
  int currentIndex = 0;
  final HomeController controller = Get.find();
  @override
  void initState() {
    audioController.playlist =
      controller.listsongdata.map((element) => element.assetLink).toList();
    controller.audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        setState(() {
          isPlaying = true;
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
    });

    controller.audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duartion = event;
      });
      controller.audioPlayer.onPositionChanged.listen((Duration positio) {
        setState(() {
          position = positio;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 240, 235, 235),
                blurRadius: 3.0,
                spreadRadius: 3),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              svgWidget('assets/svg/music.svg'),
              const SizedBox(
                width: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  colorText(
                          controller
                              .songdata[audioController.currentIndex].name,
                          16,
                          fontWeight: FontWeight.w700,
                          color: blueColor)
                      .paddingOnly(bottom: 2),
                ],
              ).paddingOnly(left: 15)
            ],
          ),
          Slider(
            value: position.inSeconds.clamp(0, duartion.inSeconds).toDouble(),
            activeColor: blueColor,
            inactiveColor: Colors.grey,
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await controller.audioPlayer.seek(position);
            },
            min: 0,
            max: duartion.inSeconds.toDouble(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              colorText(controller.formatDuration(position), 12,
                  color: Colors.grey),
              colorText(controller.formatDuration(duartion), 12,
                  color: Colors.grey)
            ],
          ).paddingOnly(left: 25, right: 25, bottom: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    controller.audioPlayer1.pause();
                    audioController.playPreviousSong(controller.audioPlayer);
                  },
                  child: svgWidget('assets/svg/backward.svg')),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  controller.audioPlayer1.pause();
                  isPlaying
                      ? audioController.pause(controller.audioPlayer)
                      : audioController.play(controller.audioPlayer);
                },
                child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        gradient: primaryColor, shape: BoxShape.circle),
                    child: isPlaying
                        ? svgWidget(
                            'assets/svg/pause_button.svg',
                          )
                        : svgWidget("assets/svg/play_white.svg")),
              ),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                  onTap: () {
                    controller.audioPlayer1.pause();
                    audioController.playNextSong(controller.audioPlayer);
                  },
                  child: svgWidget('assets/svg/forward.svg')),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.audioPlayer1.stop();
    controller.audioPlayer.stop();
    controller.audioPlayer.dispose();
    controller.audioPlayer1.dispose();
    super.dispose();
  }
}

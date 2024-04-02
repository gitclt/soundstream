import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/controllers/home_controller.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';

class AudioPlayButton extends StatefulWidget {
  const AudioPlayButton({super.key});

  @override
  State<AudioPlayButton> createState() => _AudioPlayButtonState();
}

class _AudioPlayButtonState extends State<AudioPlayButton> {
  bool isState = false;
  bool isPlaying = false;
  // AudioPlayerService audioController = AudioPlayerService();

  List<String> existingFilePaths = [];
  Duration duartion = Duration.zero;
  Duration position = Duration.zero;
  int currentIndex = 0;
  final HomeController controller = Get.find();
  @override
  void initState() {
    controller.audioController.playlist =
        controller.songdata.map((element) => element.assetLink).toList();
    controller.audioController.currentIndex = controller.songIndex.value;
    controller.audioController.play(controller.audioPlayer2);
    controller.audioPlayer2.onPlayerStateChanged.listen((event) {
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
    controller.audioPlayer2.onPlayerComplete.listen((event) {
      if (controller.songdata.length != 1) {
        controller.isLoading(true);
        controller
            .setPlayingAtIndex(controller.audioController.currentIndex + 1);
        controller.isLoading(false);
      }
    });

    controller.audioPlayer2.onDurationChanged.listen((event) {
      setState(() {
        duartion = event;
      });
      controller.audioPlayer2.onPositionChanged.listen((Duration positio) {
        setState(() {
          position = positio;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.audioController.playlist =
          controller.songdata.map((element) => element.assetLink).toList();
      // LocationService().checkLocation(controller.songdata);
      return Column(
        children: [
          Image.asset(
            'assets/image/music_image.png',
            height: 100,
            width: 100,
          ),
          Obx(() => controller.audioController.currentIndex != -1
              ? colorText(
                      // ignore: unnecessary_null_comparison
                      controller.listsongdata
                          .where((e) => e.isPlaying == true)
                          .first
                          .name,
                      20,
                      fontWeight: FontWeight.w700,
                      color: blueColor)
                  .paddingOnly(
                  top: 15,
                )
              : const Text("")),
          Slider(
            value: position.inSeconds.clamp(0, duartion.inSeconds).toDouble(),
            activeColor: blueColor,
            inactiveColor: Colors.grey,
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await controller.audioPlayer2.seek(position);
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
          ).paddingOnly(left: 25, right: 25, bottom: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      if (!controller.songdata
                              .every((e) => e.assetLink != "") &&
                          controller
                                  .songdata[
                                      controller.audioController.currentIndex -
                                          1]
                                  .assetLink ==
                              "") {
                      } else {
                        if (controller.songdata.length != 1) {
                          controller.isLoading(true);

                          controller.audioController
                              .playPreviousSong(controller.audioPlayer2);
                          controller.isaudioIndex.value =
                              controller.audioController.currentIndex;
                          controller.setPlayingAtIndex(
                              controller.audioController.currentIndex);

                          controller.isLoading(false);
                        }
                      }
                    });
                  },
                  child: svgWidget('assets/svg/backward.svg')),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () => isPlaying
                    ? controller.audioController.pause(controller.audioPlayer2)
                    : controller.audioController.play(controller.audioPlayer2),
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
                    setState(() {
                      if (!controller.songdata
                              .every((e) => e.assetLink != "") &&
                          controller
                                  .songdata[
                                      controller.audioController.currentIndex +
                                          1]
                                  .assetLink ==
                              "") {
                      } else {
                        if (controller.songdata.length != 1) {
                          controller.isLoading(true);

                          controller.audioController
                              .playNextSong(controller.audioPlayer2);

                          controller.isaudioIndex.value =
                              controller.audioController.currentIndex;
                          controller.setPlayingAtIndex(
                              controller.audioController.currentIndex);

                          controller.isLoading(false);
                        }
                      }
                    });
                  },
                  child: svgWidget('assets/svg/forward.svg')),
            ],
          )
        ],
      );
    });
  }

  @override
  void dispose() {
    // controller.audioPlayer2.stop();
    // controller.audioPlayer2.dispose();
    super.dispose();
  }
}

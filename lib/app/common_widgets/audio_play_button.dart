import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/audio/controllers/audio_controller.dart';
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
  final AudioController controller = Get.find();
  @override
  void initState() {
    controller.audioController.playlist = controller.songDataList;
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
    return Column(
      children: [
        Image.asset('assets/image/music_image.png'),
        Obx(() => controller.isaudioIndex.value == 0
            ? colorText(
                    controller
                        .songDataList[controller.audioController.currentIndex]
                        .split("/")
                        .last,
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
                  setState(() {
                    controller.audioController
                        .playPreviousSong(controller.audioPlayer);
                    controller.isaudioIndex.value =
                        controller.audioController.currentIndex;
                  });
                },
                child: svgWidget('assets/svg/backward.svg')),
            const SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () => isPlaying
                  ? controller.audioController.pause(controller.audioPlayer)
                  : controller.audioController.play(controller.audioPlayer),
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
                    controller.audioController
                        .playNextSong(controller.audioPlayer);
                    controller.isaudioIndex.value =
                        controller.audioController.currentIndex;
                  });
                },
                child: svgWidget('assets/svg/forward.svg')),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.audioPlayer.dispose();
    controller.audioPlayer.stop();
    super.dispose();
  }
}

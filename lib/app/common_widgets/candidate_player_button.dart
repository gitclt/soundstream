import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/controllers/home_controller.dart';
import 'package:sound_stream_flutter_app/app/service/audio.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';

class CandidateAudioPlayButton extends StatefulWidget {
  const CandidateAudioPlayButton({super.key});

  @override
  State<CandidateAudioPlayButton> createState() =>
      _CandidateAudioPlayButtonState();
}

class _CandidateAudioPlayButtonState extends State<CandidateAudioPlayButton> {
  AudioPlayerService audioController = AudioPlayerService();
  bool isState = false;
  bool isPlaying = false;
  List<String> existingFilePaths = [];
  Duration duartion = Duration.zero;
  Duration position = Duration.zero;
  int currentIndex = 0;
  final HomeController controller = Get.find();
  @override
  void initState() {
    audioController.playlist = controller.candiateSong;
    controller.audioPlayer1.onPlayerStateChanged.listen((event) {
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

    controller.audioPlayer1.onDurationChanged.listen((event) {
      setState(() {
        duartion = event;
      });
      controller.audioPlayer1.onPositionChanged.listen((Duration positio) {
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
          color: blueColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 240, 235, 235),
                blurRadius: 3.0,
                spreadRadius: 3),
          ]),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: -18,
            left: -12,
            child: Image.asset(
              'assets/image/candidate.png',
              height: 170,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              colorText("Candidate Vote Request", 18,
                      color: Colors.white, fontWeight: FontWeight.bold)
                  .paddingOnly(bottom: 10),
              colorText("KC Venugopal", 15, color: Colors.white),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: SliderComponentShape.noThumb,
                ),
                child: Slider(
                  value: position.inSeconds
                      .clamp(0, duartion.inSeconds)
                      .toDouble(),
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await controller.audioPlayer1.seek(position);
                  },
                  min: 0,
                  max: duartion.inSeconds.toDouble(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  svgWidget('assets/svg/Playback.svg'),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      controller.audioPlayer.pause();
                      controller.audioPlayer2.pause();
                      isPlaying
                          ? audioController.pause(controller.audioPlayer1)
                          : audioController.play(controller.audioPlayer1);
                    },
                    child: isPlaying
                        ? svgWidget('assets/svg/pause_button.svg')
                        : svgWidget('assets/svg/play_white.svg'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  svgWidget('assets/svg/Next.svg'),
                ],
              )
            ],
          ).paddingOnly(left: 125),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.audioPlayer1.dispose();
    super.dispose();
  }
}

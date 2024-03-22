import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';

class CandidateAudioPlayButton extends StatelessWidget {
  const CandidateAudioPlayButton({super.key});

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
                  value: 10,
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                  onChanged: (value) async {},
                  min: 0,
                  max: 50,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  svgWidget('assets/svg/Playback.svg'),
                  const SizedBox(
                    width: 15,
                  ),
                  svgWidget(
                    'assets/svg/pause_button.svg',
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
}

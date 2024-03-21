import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';

class HomePlayButton extends StatelessWidget {
  const HomePlayButton({super.key});

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
                  colorText('പാർട്ടി സമ്മേളനം', 16, fontWeight: FontWeight.w700)
                      .paddingOnly(bottom: 2),
                  blackText('Minister A', 14, fontWeight: FontWeight.w500),
                ],
              )
            ],
          ),
          Slider(
            value: 10,
            activeColor: blueColor,
            inactiveColor: Colors.grey,
            onChanged: (value) async {},
            min: 0,
            max: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              colorText("0:12", 12, color: Colors.grey),
              colorText("3:15", 12, color: Colors.grey)
            ],
          ).paddingOnly(left: 25, right: 25, bottom: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              svgWidget('assets/svg/backward.svg'),
              const SizedBox(
                width: 15,
              ),
              Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      gradient: primaryColor, shape: BoxShape.circle),
                  child: svgWidget(
                    'assets/svg/pause_button.svg',
                  )),
              const SizedBox(
                width: 15,
              ),
              svgWidget('assets/svg/forward.svg'),
            ],
          )
        ],
      ),
    );
  }
}

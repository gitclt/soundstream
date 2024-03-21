import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';

class AudioPlayButton extends StatelessWidget {
  const AudioPlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/image/music_image.png'),
        colorText('പാർട്ടി സമ്മേളനം', 20,
                fontWeight: FontWeight.w700, color: blueColor)
            .paddingOnly(top: 15, right: 150),
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
    );
  }
}

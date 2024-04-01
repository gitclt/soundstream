import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';

class HomeCard extends StatelessWidget {
  final String name, number;
  const HomeCard({
    super.key,
    required this.name,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        elevation: 10.0,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.,
          children: [
            const SizedBox(
              width: 5,
            ),
            svgWidget(
              'assets/svg/home_profie.svg',
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                blackText(name, 16, fontWeight: FontWeight.w500),
                const SizedBox(
                  height: 5,
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  svgWidget('assets/svg/vehicle.svg', color: Colors.black54),
                  const SizedBox(
                    width: 5,
                  ),
                  blackText(number, 16, fontWeight: FontWeight.w700)
                ])
              ],
            ),
          ],
        ).paddingOnly(bottom: 10));
  }
}

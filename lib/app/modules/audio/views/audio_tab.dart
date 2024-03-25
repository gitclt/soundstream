import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/audio/controllers/audio_controller.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';

class AudioBuilder extends GetView<AudioController> {
  const AudioBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.songDataList.length,
      itemBuilder: (context, index) {
        return Obx(() => CategoryCard(
              color: controller.audioController.currentIndex == index
                  ? blueColor.withOpacity(0.3)
                  : Colors.white,
              audioname: controller.songDataList[index].split("/").last,
              name: controller.isaudioIndex.value == 0 ? '' : "",
              ontap: () {
                controller.audioController.playlist = controller.songDataList;
                controller.audioController.pause(controller.audioPlayer);
                controller.audioController.currentIndex = index;
                controller.isaudioIndex.value = index;
                controller.audioController.play(controller.audioPlayer);
              },
            ).paddingAll(3));
      },
    );
  }
}

class CategoryCard extends GetView<AudioController> {
  final String audioname;
  final String name;
  final Color color;
  final Function ontap;
  const CategoryCard({
    required this.audioname,
    required this.color,
    required this.name,
    required this.ontap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(width: 0.5, color: Colors.grey),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 240, 235, 235),
                  blurRadius: 3.0,
                  spreadRadius: 3),
            ]),
        child: Row(
          children: [
            svgWidget('assets/svg/Button_Play.svg'),
            const SizedBox(
              width: 6,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                blackText(audioname, 16, fontWeight: FontWeight.w700),
                colorText(name, 14,
                    fontWeight: FontWeight.w500, color: Colors.grey),
              ],
            ).paddingOnly(top: 2),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

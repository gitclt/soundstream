import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/controllers/home_controller.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';

class CategoryBuilder extends GetView<HomeController> {
  const CategoryBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? const Center()
        : ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.songdata.length,
            itemBuilder: (context, index) {
              return CategoryCard(
                color: controller.audioController.currentIndex == index
                    ? blueColor.withOpacity(0.3)
                    : Colors.white,
                audioname: controller.songdata[index].name,
                name: '',
                ontap: () {
                  controller.isLoading(true);
                  controller.audioController.currentIndex = index;
                  controller.audioPlayer.stop();
                  controller.audioPlayer1.stop();
                  controller.songIndex.value = index;
                  controller.audioController.playlist = controller.songdata
                      .map((element) => element.assetLink)
                      .toList();
                  // controller.audioController.pause(controller.audioPlayer2);

                  controller.isaudioIndex.value = index;
                  controller.audioController.play(controller.audioPlayer2);
                  controller.setPlayingAtIndex(index);
                  controller.isLoading(false);
                  Get.toNamed(
                    Routes.AUDIO,
                  );
                },
              ).paddingAll(3);
            },
          ));
  }
}

class CategoryCard extends GetView<HomeController> {
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

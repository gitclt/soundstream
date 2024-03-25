import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/audio_play_button.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/tab_bar.dart';
import 'package:sound_stream_flutter_app/app/modules/audio/views/audio_tab.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';
import '../controllers/audio_controller.dart';

class AudioView extends GetView<AudioController> {
  const AudioView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        bottomOpacity: 0,
      ),
      body: Column(
        children: [
          const Center(child: AudioPlayButton()),
          Expanded(
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 240, 235, 235),
                          blurRadius: 3.0,
                          spreadRadius: 3),
                    ]),
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        blackText('Categories', 20, fontWeight: FontWeight.w700)
                            .paddingSymmetric(vertical: 10, horizontal: 8),
                        Obx(() => TabBar(
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                controller: controller.mainController,
                                unselectedLabelColor: Colors.black,
                                isScrollable: true,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.transparent,
                                ),
                                onTap: (int index) {
                                  controller.isIndex.value = index;
                                  if (index == 0) {
                                    controller.categoryFilter("");
                                  } else if (index == 1) {
                                    controller.categoryFilter("2");
                                  } else if (index == 2) {
                                    controller.categoryFilter("1");
                                  }
                                },
                                tabs: [
                                  buildTab(
                                    "All",
                                    controller.isIndex.value == 0
                                        ? Colors.white
                                        : Colors.black,
                                    controller.isIndex.value == 0
                                        ? blueColor
                                        : Colors.white,
                                  ),
                                  buildTab(
                                    "Speeches",
                                    controller.isIndex.value == 1
                                        ? Colors.white
                                        : Colors.black,
                                    controller.isIndex.value == 1
                                        ? blueColor
                                        : Colors.white,
                                  ),
                                  buildTab(
                                    "Song",
                                    controller.isIndex.value == 2
                                        ? Colors.white
                                        : Colors.black,
                                    controller.isIndex.value == 2
                                        ? blueColor
                                        : Colors.white,
                                  ),
                                ]).paddingOnly(right: 100)),
                        Expanded(
                            child: TabBarView(
                          controller: controller.mainController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: const [
                            AudioBuilder(),
                            AudioBuilder(),
                            AudioBuilder(),
                          ],
                        )),
                      ]),
                )).paddingAll(10),
          ),
        ],
      ),
    );
  }
}

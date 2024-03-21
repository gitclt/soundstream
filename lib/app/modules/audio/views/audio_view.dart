import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/audio_play_button.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/category_card.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/tab_bar.dart';
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
          Container(
              height: 280,
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
                child: Column(children: [
                  Obx(() => TabBar(
                          controller: controller.mainController,
                          unselectedLabelColor: Colors.black,
                          isScrollable: true,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent,
                          ),
                          onTap: (int index) {
                            controller.isIndex.value = index;
                            if (index == 1) {}
                          },
                          tabs: [
                            buildTab(
                              "All",
                              controller.isIndex.value == 0
                                  ? Colors.white
                                  : blueColor,
                              controller.isIndex.value == 0
                                  ? blueColor
                                  : Colors.white,
                            ),
                            buildTab(
                              "Speeches",
                              controller.isIndex.value == 1
                                  ? Colors.white
                                  : blueColor,
                              controller.isIndex.value == 1
                                  ? blueColor
                                  : Colors.white,
                            ),
                            buildTab(
                              "Song",
                              controller.isIndex.value == 2
                                  ? Colors.white
                                  : blueColor,
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
                      CategoryBuilder(),
                      CategoryBuilder(),
                      CategoryBuilder(),
                    ],
                  )),
                ]),
              )).paddingAll(10),
        ],
      ),
    );
  }
}

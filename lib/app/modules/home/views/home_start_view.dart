import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/category_card.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/play_audio_button.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/tab_bar.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/custom_switch.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/home_end_view.dart';
import 'package:sound_stream_flutter_app/common_widgets/card/home_card.dart';
import 'package:sound_stream_flutter_app/common_widgets/card/home_top_card.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';
import '../controllers/home_controller.dart';

class StartView extends GetView<HomeController> {
  const StartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeHeader(
              feild: Padding(
                padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSwitch(
                        value: true,
                        onChanged: (value) {
                          Get.to(const EndView());
                        },
                      ),
                      InkWell(child: svgWidget('assets/svg/sync.svg'))
                    ],
                  ),
                  Row(
                    children: [
                      svgWidget("assets/svg/location.svg"),
                      const SizedBox(
                        width: 5,
                      ),
                      colorText('Nadakkavu, Kozhikode', 14,
                          color: Colors.white, fontWeight: FontWeight.w500),
                      const SizedBox(
                        width: 20,
                      ),
                      svgWidget('assets/svg/time.svg'),
                      const SizedBox(
                        width: 5,
                      ),
                      colorText('12:30', 14,
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ],
                  ).paddingOnly(
                    top: 25,
                  )
                ]),
              ),
              homecard: const HomeCard(
                name: 'Rajesh Raj',
                number: 'KL11 N 6789',
              )),
          Expanded(
              child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomePlayButton(),
                    blackText('Categories', 20, fontWeight: FontWeight.w700)
                        .paddingSymmetric(vertical: 20),
                    SizedBox(
                        height: 280,
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
                        )),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

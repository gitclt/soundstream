import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/candidate_player_button.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/category_card.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/play_audio_button.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/tab_bar.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/custom_switch.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';
import 'package:sound_stream_flutter_app/app/service/sessio.dart';
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
              height: 180,
              stackheight: 140,
              feild: Padding(
                padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSwitch(
                        value: Session.isCheckin,
                        onChanged: (value) {
                          controller.getCheckIn();

                          // Get.to(const EndView());
                        },
                      ),
                      InkWell(
                          onTap: () async {
                            final res = await Get.toNamed(Routes.DATA_SYNCING,
                                arguments: "sync");
                            if (res == true) {
                              controller.getSongData();
                            }
                          },
                          child: svgWidget('assets/svg/sync.svg'))
                    ],
                  ),
                  Row(
                    children: [
                      svgWidget("assets/svg/location.svg"),
                      const SizedBox(
                        width: 5,
                      ),
                      colorText(Session.place, 14,
                          color: Colors.white, fontWeight: FontWeight.w500),
                      const SizedBox(
                        width: 20,
                      ),
                      svgWidget('assets/svg/time.svg'),
                      const SizedBox(
                        width: 5,
                      ),
                      colorText(Session.time, 14,
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ],
                  ).paddingOnly(
                    top: 25,
                  )
                ]),
              ),
              homecard: HomeCard(
                name: Session.userName,
                number: Session.vehicle,
              )),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.songDataList.isEmpty
                            ? const SizedBox()
                            : const HomePlayButton().paddingOnly(bottom: 30)),
                    Obx(() => controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.candiateSong.isEmpty
                            ? const SizedBox()
                            : const CandidateAudioPlayButton()),
                    blackText('Categories', 20, fontWeight: FontWeight.w700)
                        .paddingSymmetric(vertical: 10),
                    SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: DefaultTabController(
                          length: 4,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => controller.isLoading.value
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : TabBar(
                                            controller:
                                                controller.mainController,
                                            unselectedLabelColor: Colors.black,
                                            isScrollable: true,
                                            indicator: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                                              } else if (index == 3) {
                                                controller.categoryFilter("3");
                                              }
                                            },
                                            labelPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 6.0),
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
                                                  "Songs",
                                                  controller.isIndex.value == 2
                                                      ? Colors.white
                                                      : Colors.black,
                                                  controller.isIndex.value == 2
                                                      ? blueColor
                                                      : Colors.white,
                                                ),
                                                buildTab(
                                                  "Announcement",
                                                  controller.isIndex.value == 3
                                                      ? Colors.white
                                                      : Colors.black,
                                                  controller.isIndex.value == 3
                                                      ? blueColor
                                                      : Colors.white,
                                                ),
                                              ])
                                    // .paddingOnly(right: 70)
                                    ),
                                Obx(
                                  () => controller.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Expanded(
                                          child: TabBarView(
                                          controller: controller.mainController,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: const [
                                            CategoryBuilder(),
                                            CategoryBuilder(),
                                            CategoryBuilder(),
                                            CategoryBuilder(),
                                          ],
                                        )),
                                )
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

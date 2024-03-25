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
                              controller.getSongDetails();
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
                        : controller.listsongdata.isEmpty
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
                    DefaultTabController(
                      length: 4,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => controller.isLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : TabBar(
                                        controller: controller.mainController,
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
                                            controller.categoryFilter("4");
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
                                  : const CategoryBuilder(),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex.value,
            elevation: 0,
            onTap: (int index) async {
              controller.selectedIndex.value = index;
            },
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: controller.selectedIndex.value == 0
                        ? svgWidget('assets/svg/Home.svg',
                            color: controller.selectedIndex.value == 0
                                ? blueColor
                                : Colors.black)
                        : svgWidget('assets/svg/home1.svg'),
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: controller.selectedIndex.value == 1
                        ? svgWidget('assets/svg/circle_profile1.svg',
                            color: controller.selectedIndex.value == 1
                                ? blueColor
                                : Colors.black)
                        : svgWidget('assets/svg/circle_profile.svg'),
                  ),
                  label: 'Profile')
            ]),
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     currentIndex: controller.selectedIndex.value,
      //     elevation: 0,
      //     onTap: (int index) async {
      //       controller.selectedIndex.value = index;
      //     },
      //     items: [
      //       BottomNavigationBarItem(
      //           icon: Padding(
      //             padding: const EdgeInsets.only(bottom: 5.0),
      //             child: controller.selectedIndex.value == 0
      //                 ? svgWidget('assets/svg/Home.svg',
      //                     color: controller.selectedIndex.value == 0
      //                         ? blueColor
      //                         : Colors.black)
      //                 : svgWidget('assets/svg/home1.svg'),
      //           ),
      //           label: 'Home'),
      //       // BottomNavigationBarItem(
      //       //     icon: Padding(
      //       //       padding: const EdgeInsets.only(bottom: 5.0),
      //       //       child: svgWidget('assets/svg/bottom_search.svg',
      //       //           color: controller.selectedIndex.value == 1
      //       //               ? redColor
      //       //               : Colors.black),
      //       //     ),
      //       //     label: 'Search'),
      //       BottomNavigationBarItem(
      //           icon: Padding(
      //             padding: const EdgeInsets.only(bottom: 5.0),
      //             child: controller.selectedIndex.value == 1
      //                 ? svgWidget('assets/svg/circle_profile1.svg',
      //                     color: controller.selectedIndex.value == 1
      //                         ? blueColor
      //                         : Colors.black)
      //                 : svgWidget('assets/svg/circle_profile.svg'),
      //           ),
      //           label: 'Profile')
      //     ]),
    );
  }
}

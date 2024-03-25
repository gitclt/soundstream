import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/custom_switch.dart';
import 'package:sound_stream_flutter_app/app/service/sessio.dart';
import 'package:sound_stream_flutter_app/common_widgets/card/home_card.dart';
import 'package:sound_stream_flutter_app/common_widgets/card/home_top_card.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';

import '../controllers/home_controller.dart';

class EndView extends GetView<HomeController> {
  const EndView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isTripLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                HomeHeader(
                    height: 230,
                    stackheight: 180,
                    feild: Padding(
                      padding:
                          const EdgeInsets.only(top: 50, left: 15, right: 15),
                      child: Column(children: [
                        controller.checkInDataList.first.date !=
                                controller.dateToFormatted(controller.datetime)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomSwitch(
                                    value: false,
                                    onChanged: (value) {},
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    colorText('Start', 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Rowtext(
                                        path: "assets/svg/location.svg",
                                        title: controller.checkInDataList.first
                                            .checkInLocation),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Rowtext(
                                        path: 'assets/svg/time.svg',
                                        title: controller
                                            .checkInDataList.first.checkInTime),
                                  ],
                                ).paddingOnly(
                                  top: 10,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                colorText('End', 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                                const SizedBox(
                                  height: 10,
                                ),
                                Rowtext(
                                    path: "assets/svg/location.svg",
                                    title: controller.checkInDataList.first
                                        .checkOutLocation),
                                const SizedBox(
                                  height: 10,
                                ),
                                Rowtext(
                                    path: 'assets/svg/time.svg',
                                    title: controller
                                        .checkInDataList.first.checkOutTime),
                              ],
                            ).paddingOnly(
                              top: 10,
                            ),
                          ],
                        )
                      ]),
                    ),
                    homecard: HomeCard(
                        name: Session.userName, number: Session.userMobile)),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                  child: blackText(
                      "Yours today's journey ends here \nThank you", 22,
                      fontWeight: FontWeight.w700),
                )),
              ]),
      ),
      // bottomNavigationBar: Obx(
      //   () => BottomNavigationBar(
      //       type: BottomNavigationBarType.fixed,
      //       currentIndex: controller.selectedIndex.value,
      //       elevation: 0,
      //       onTap: (int index) async {
      //         controller.selectedIndex.value = index;
      //       },
      //       items: [
      //         BottomNavigationBarItem(
      //             icon: Padding(
      //               padding: const EdgeInsets.only(bottom: 5.0),
      //               child: controller.selectedIndex.value == 0
      //                   ? svgWidget('assets/svg/Home.svg',
      //                       color: controller.selectedIndex.value == 0
      //                           ? blueColor
      //                           : Colors.black)
      //                   : svgWidget('assets/svg/home1.svg'),
      //             ),
      //             label: 'Home'),
           
      //         BottomNavigationBarItem(
      //             icon: Padding(
      //               padding: const EdgeInsets.only(bottom: 5.0),
      //               child: controller.selectedIndex.value == 1
      //                   ? svgWidget('assets/svg/circle_profile1.svg',
      //                       color: controller.selectedIndex.value == 1
      //                           ? blueColor
      //                           : Colors.black)
      //                   : svgWidget('assets/svg/circle_profile.svg'),
      //             ),
      //             label: 'Profile')
      //       ]),
      // ),
    );
  }
}

class Rowtext extends StatelessWidget {
  final String path, title;

  const Rowtext({
    super.key,
    required this.path,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        svgWidget(path),
        const SizedBox(
          width: 5,
        ),
        colorText(title, 12, color: Colors.white, fontWeight: FontWeight.w500),
      ],
    );
  }
}

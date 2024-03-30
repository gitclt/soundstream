import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/controllers/home_controller.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/custom_switch.dart';
import 'package:sound_stream_flutter_app/app/service/sessio.dart';
import 'package:sound_stream_flutter_app/common_widgets/card/home_card.dart';
import 'package:sound_stream_flutter_app/common_widgets/card/home_top_card.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        HomeHeader(
            height: 160,
            stackheight: 110,
            homecard: HomeCard(
              name: Session.userName,
              number: Session.vehicle,
            )),
        Obx(
          () => controller.isLoading.value
              ? const Center()
              : controller
                          .calculatePercentage(
                              int.parse(controller.songsList
                                  .where((element) =>
                                      element.downloadPercentage.value == "100")
                                  .length
                                  .toString()),
                              int.parse(controller.songsList.length.toString()))
                          .toStringAsFixed(0) ==
                      '100'
                  ? const SizedBox()
                  : Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              width: 1, color: Colors.grey.withOpacity(0.3))),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              blackText(" Data Syncing Processing", 15,
                                      fontWeight: FontWeight.bold)
                                  .paddingOnly(left: 15),
                              const Spacer(),
                              Obx(
                                () => colorText(
                                        "${controller.calculatePercentage(int.parse(controller.songsList.where((element) => element.downloadPercentage.value == "100").length.toString()), int.parse(controller.songsList.length.toString())).toStringAsFixed(0)} % Done",
                                        15,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xffFF9737))
                                    .paddingOnly(right: 25),
                              )
                            ],
                          ),
                          Obx(
                            () => controller.isLoading.value
                                ? const Center()
                                : SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      thumbShape: SliderComponentShape.noThumb,
                                      trackHeight: 8,
                                    ),
                                    child: Slider(
                                      value: controller.songsList
                                          .where((element) =>
                                              element
                                                  .downloadPercentage.value ==
                                              "100")
                                          .length
                                          .toDouble(),
                                      activeColor: const Color(0xffFF9737),
                                      inactiveColor: const Color(0xffFF9737)
                                          .withOpacity(0.5),
                                      onChanged: (value) async {},
                                      min: 0,
                                      max: controller.songsList.length
                                          .toDouble(),
                                    ),
                                  ),
                          ),
                        ],
                      ).paddingOnly(top: 10),
                    ).paddingAll(10),
        ).paddingOnly(top: 60),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              blackText('Start your Trip to\nsee all Features', 22,
                  fontWeight: FontWeight.w700),
              const SizedBox(
                width: 15,
              ),
              CustomSwitch(
                value: Session.isCheckin,
                onChanged: (value) async {
                  await controller.fetchLocation();
                },
              )
            ],
          ),
        )),
      ]),
    );
  }
}

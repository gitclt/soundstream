import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/common_appbar.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';
import 'package:sound_stream_flutter_app/app/service/sessio.dart';
import 'package:sound_stream_flutter_app/common_widgets/button/gradient_button.dart';
import 'package:sound_stream_flutter_app/common_widgets/card/home_card.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import '../controllers/data_syncing_controller.dart';

class DataSyncingView extends GetView<DataSyncingController> {
  const DataSyncingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        appText: 'Data Syncing',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            HomeCard(
              name: Session.userName,
              number: Session.vehicle,
            ),
            blackText('Audios', 20, fontWeight: FontWeight.w700)
                .paddingOnly(left: 10, top: 8),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => controller.isLoading.value
                      ? const Center()
                      : colorText(
                              "${controller.calculatePercentage(int.parse(controller.songdata.where((element) => element.downloadPercentage.value == "100").length.toString()), int.parse(controller.songdata.length.toString())).toStringAsFixed(0)} % Done",
                              15,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffFF9737))
                          .paddingOnly(left: 10),
                )
              ],
            ).paddingOnly(right: 15),
            Obx(
              () => controller.isLoading.value
                  ? const Center()
                  : SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: SliderComponentShape.noThumb,
                      ),
                      child: Slider(
                        value: controller.songdata
                            .where((element) =>
                                element.downloadPercentage.value == "100")
                            .length
                            .toDouble(),
                        activeColor: const Color(0xffFF9737),
                        inactiveColor: const Color(0xffFF9737).withOpacity(0.5),
                        onChanged: (value) async {},
                        min: 0,
                        max: controller.songdata.length.toDouble(),
                      ),
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: controller.songdata.length,
                      itemBuilder: (context, index) {
                        final item = controller.songdata[index];
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(255, 240, 235, 235),
                                    blurRadius: 3.0,
                                    spreadRadius: 3),
                              ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              svgWidget('assets/svg/Button_Play.svg'),
                              const SizedBox(
                                width: 15,
                              ),
                              Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    blackText(item.name, 14,
                                        fontWeight: FontWeight.w600),
                                    colorText(item.name, 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey)
                                        .paddingOnly(top: 5),
                                    if (item.downloadPercentage.value != "100")
                                      controller.songnameIndex.value == index
                                          ? colorText("Downloading...", 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.green)
                                              .paddingOnly(top: 5)
                                          : const SizedBox(),
                                  ],
                                ).paddingOnly(top: 5),
                              ),
                              const Spacer(),

                              // Obx(() => CircularPercentIndicator(
                              //       radius: 25.0,
                              //       lineWidth: 5.0,
                              //       percent: controller.prog.value ?? 0,
                              //       center: Text(
                              //         "${((controller.prog.value ?? 0) * 100).toStringAsFixed(0)}%",
                              //         style: const TextStyle(
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 12.0,
                              //             color: Color(0xFFFF9737)),
                              //       ),
                              //       progressColor: const Color(0xFFFF9737),
                              //       circularStrokeCap: CircularStrokeCap.round,
                              //     )),

                              Obx(
                                () => CircularPercentIndicator(
                                  radius: 25.0,
                                  lineWidth: 5.0,
                                  animation: true,
                                  percent: item.downloadPercentage.value != ""
                                      ? double.parse(
                                              item.downloadPercentage.value) /
                                          100
                                      : 0.0,
                                  center: Text(
                                    "${item.downloadPercentage}%",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                        color: Color(0xFFFF9737)),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: const Color(0xFFFF9737),
                                ).paddingOnly(
                                  bottom: 10,
                                ),
                              )
                            ],
                          ),
                        ).paddingAll(3);
                      },
                    ),
            ).paddingAll(2)),
            Obx(
              () => controller.allSongsDownloaded.value
                  ? CommonButtonWidget(
                      label: 'Complete',
                      isLoading: controller.isLoading.value,
                      onClick: () {
                        if (controller.arg == "sync") {
                          Get.back(result: true);
                        } else {
                          Get.offAllNamed(Routes.SPLASH);
                        }
                      },
                    ).paddingSymmetric(horizontal: 4, vertical: 6)

                  //  Center(
                  //     child: InkWell(
                  //       onTap: () {
                  //         if (controller.arg == "sync") {
                  //           Get.back(result: true);
                  //         } else {
                  //           Get.offAllNamed(Routes.SPLASH);
                  //         }
                  //       },
                  //       child:
                  //        Container(
                  //         height: 60,
                  //         width: 300,
                  //         decoration: BoxDecoration(
                  //           gradient: primaryColor,
                  //           borderRadius: BorderRadius.circular(15),
                  //         ),
                  //         child: Center(
                  //           child: colorText(
                  //             "Complete",
                  //             18,
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ).paddingSymmetric(vertical: 10),
                  //     ),
                  //   )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';

// class DataSyncingCard extends StatelessWidget {
//   final int startingValue;
//   final int totalValue;
//   const DataSyncingCard({super.key, required this.startingValue, required this.totalValue});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(width: 1, color: Colors.grey)),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               blackText(" Data Syncing Processing", 15,
//                   fontWeight: FontWeight.bold),
//               const Spacer(),
//               colorText(
//                       "25",
//                       // "${controller.calculatePercentage(int.parse(controller.songdata.where((element) => element.downloadPercentage.value == "100").length.toString()), int.parse(controller.songdata.length.toString())).toStringAsFixed(0)} % Done",
//                       15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color(0xffFF9737))
//                   .paddingOnly(left: 10),
//             ],
//           ),
//           Obx(
//             () => controller.isLoading.value
//                 ? const Center()
//                 : SliderTheme(
//                     data: SliderTheme.of(context).copyWith(
//                       thumbShape: SliderComponentShape.noThumb,
//                     ),
//                     child: Slider(
//                       value: controller.songdata
//                           .where((element) =>
//                               element.downloadPercentage.value == "100")
//                           .length
//                           .toDouble(),
//                       activeColor: const Color(0xffFF9737),
//                       inactiveColor: const Color(0xffFF9737).withOpacity(0.5),
//                       onChanged: (value) async {},
//                       min: 0,
//                       max: controller.songdata.length.toDouble(),
//                     ),
//                   ),
//           ),
//         ],
//       ).paddingOnly(left: 10, right: 10, top: 10),
//     ).paddingAll(10);
//   }
// }

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/category_card.dart';
import 'package:sound_stream_flutter_app/common_widgets/card/home_card.dart';
import 'package:sound_stream_flutter_app/common_widgets/card/home_top_card.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';

import '../controllers/data_syncing_controller.dart';

class DataSyncingView extends GetView<DataSyncingController> {
  const DataSyncingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(
              feild: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  colorText('Data Syncing', 18,
                      color: Colors.white, fontWeight: FontWeight.w500)
                ],
              ),
              height: 100,
              stackheight: 110,
              homecard: const HomeCard(
                name: 'Rajesh Raj',
                number: 'KL11 N 6789',
              )),
          Padding(
            padding: const EdgeInsets.only(top: 110, left: 15),
            child: Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blackText('Audios', 20, fontWeight: FontWeight.w700),
                Container(
                  height: 121,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          blackText('പാർട്ടി സമ്മേളനം', 16,
                              fontWeight: FontWeight.w700),
                          Row(
                            children: [
                              colorText('4:24', 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                              const VerticalDivider(
                                  thickness: 2, color: Colors.grey),
                              colorText('Minister A', 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                      CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 5.0,
                        animation: true,
                        percent: 0.7,
                        center: Text(
                          "70.0%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Color(0xFFFF9737)),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Color(0xFFFF9737),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }
}

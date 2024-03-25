import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/custom_switch.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/home_start_view.dart';
import 'package:sound_stream_flutter_app/common_widgets/card/home_card.dart';
import 'package:sound_stream_flutter_app/common_widgets/card/home_top_card.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        HomeHeader(
            height: 160,
            stackheight: 110,
            homecard: const HomeCard(
              name: 'Rajesh Raj',
              number: 'KL11 N 6789',
            )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              blackText('Start your Trip to\n see all Features', 22,
                  fontWeight: FontWeight.w700),
              const SizedBox(
                width: 15,
              ),
              Obx(() => CustomSwitch(
                    value: controller.isCheckin.value,
                    onChanged: (value) async {
                      controller.getSongData();
                      await controller.fetchLocation();
                      // Get.to(const StartView());
                    },
                  ))
            ],
          ),
        )),
      ]),
    );
  }
}

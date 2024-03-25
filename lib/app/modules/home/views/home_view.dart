import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/controllers/home_trip_controller.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/custom_switch.dart';
import 'package:sound_stream_flutter_app/app/service/sessio.dart';
import 'package:sound_stream_flutter_app/common_widgets/card/home_card.dart';
import 'package:sound_stream_flutter_app/common_widgets/card/home_top_card.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';

class HomeView extends GetView<HomeTripController> {
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

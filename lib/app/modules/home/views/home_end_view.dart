import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/custom_switch.dart';
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
      body: Column(children: [
        HomeHeader(
            feild: Padding(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomSwitch(
                      value: false,
                      onChanged: (value) {
                        // Get.to(const StartView());
                      },
                    ),
                  ],
                ),
                Row(
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
                            const Rowtext(
                                path: "assets/svg/location.svg",
                                title: 'Nadakkavu, Kozhikode'),
                            const SizedBox(
                              height: 10,
                            ),
                            const Rowtext(
                                path: 'assets/svg/time.svg', title: '12:30'),
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
                            color: Colors.white, fontWeight: FontWeight.w500),
                        const SizedBox(
                          height: 10,
                        ),
                        const Rowtext(
                            path: "assets/svg/location.svg",
                            title: 'Nadakkavu, Kozhikode'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Rowtext(
                            path: 'assets/svg/time.svg', title: '12:30'),
                      ],
                    ).paddingOnly(
                      top: 10,
                    ),
                  ],
                )
              ]),
            ),
            homecard: const HomeCard(
              name: 'Rajesh Raj',
              number: 'KL11 N 6789',
            )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              blackText('Start your Trip \nto see all Features', 22,
                  fontWeight: FontWeight.w700),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        )),
      ]),
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
        colorText(title, 14, color: Colors.white, fontWeight: FontWeight.w500),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/controllers/dashboard_controller.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    bool shouldNavigateToFirstTab = false;
    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedIndex.value != 0) {
          shouldNavigateToFirstTab = true;
          controller.selectedIndex.value = 0;
          return false;
        } else if (shouldNavigateToFirstTab) {
          shouldNavigateToFirstTab = false;
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Obx(() => Center(
            child: controller.widgetOptions
                .elementAt(controller.selectedIndex.value))),
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
                      child: svgWidget('assets/svg/Home.svg',
                          color: controller.selectedIndex.value == 0
                              ? blueColor
                              : Colors.black),
                    ),
                    label: 'Home'),
                // BottomNavigationBarItem(
                //     icon: Padding(
                //       padding: const EdgeInsets.only(bottom: 5.0),
                //       child: svgWidget('assets/svg/bottom_search.svg',
                //           color: controller.selectedIndex.value == 1
                //               ? redColor
                //               : Colors.black),
                //     ),
                //     label: 'Search'),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: svgWidget('assets/svg/circle_profile.svg',
                          color: controller.selectedIndex.value == 1
                              ? blueColor
                              : Colors.black),
                    ),
                    label: 'Profile')
              ]),
        ),
      ),
    );
  }
}

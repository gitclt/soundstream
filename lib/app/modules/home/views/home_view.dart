import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/custom_switch.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/home_start_view.dart';

import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: CustomSliverDelegate(
                expandedHeight: 110,
              ),
            ),
            // SliverList(
            //   delegate: SliverChildListDelegate([
            //     // const SizedBox(
            //     //   height: 120,
            //     // ),
            //     Container(
            //       height: 300,
            //       color: Colors.white,
            //       child: Row(
            //         children: [
            //           blackText('Start your Trip \nto see all Features', 22,
            //               fontWeight: FontWeight.w700),
            //           SizedBox(
            //             width: 15,
            //           ),
            //           CustomSwitch(
            //             value: false,
            //             onChanged: (Value) {},
            //           )
            //         ],
            //       ),
            //     ),
            //   ]),
            // )

            SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      blackText('Start your Trip \nto see all Features', 22,
                          fontWeight: FontWeight.w700),
                      const SizedBox(
                        width: 15,
                      ),
                      CustomSwitch(
                        value: false,
                        onChanged: (value) {
                          Get.to(const StartView());
                        },
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;

  CustomSliverDelegate({
    required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              elevation: 0.0,
              flexibleSpace: Container(
                // height: 200,
                decoration: BoxDecoration(
                  gradient: primaryColor,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25 * percent),
                child:
                    //  Container(
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.all(Radius.circular(16))),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         svgWidget(
                    //           'assets/svg/circle_profile.svg',
                    //           size: 100,
                    //         ),
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             const SizedBox(
                    //               height: 30,
                    //             ),
                    //             blackText('Rajesh Raj', 16,
                    //                 fontWeight: FontWeight.w500),
                    //             const SizedBox(
                    //               height: 5,
                    //             ),
                    //             Row(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   svgWidget('assets/svg/vehicle.svg',
                    //                       color: Colors.black),
                    //                   const SizedBox(
                    //                     width: 5,
                    //                   ),
                    //                   blackText('KL11 N 6789', 16,
                    //                       fontWeight: FontWeight.w700)
                    //                 ])
                    //           ],
                    //         )
                    //       ],
                    //     ))
                    Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        elevation: 10.0,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.,
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            svgWidget(
                              'assets/svg/home_profie.svg',
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                blackText('Rajesh Raj', 16,
                                    fontWeight: FontWeight.w500),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      svgWidget('assets/svg/vehicle.svg',
                                          color: Colors.black54),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      blackText('KL11 N 6789', 16,
                                          fontWeight: FontWeight.w700)
                                    ])
                              ],
                            )
                          ],
                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 3.5;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}



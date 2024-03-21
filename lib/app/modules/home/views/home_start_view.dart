import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/category_card.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/play_audio_button.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/tab_bar.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/home_view.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';
import '../controllers/home_controller.dart';

class StartView extends GetView<HomeController> {
  const StartView({Key? key}) : super(key: key);
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
            SliverFillRemaining(
                hasScrollBody: true,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 50, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const HomePlayButton(),
                          blackText('Categories', 20,
                                  fontWeight: FontWeight.w700)
                              .paddingSymmetric(vertical: 20),
                          SizedBox(
                              height: 280,
                              child: DefaultTabController(
                                length: 3,
                                child: Column(children: [
                                  Obx(() => TabBar(
                                          controller: controller.mainController,
                                          unselectedLabelColor: Colors.black,
                                          isScrollable: true,
                                          indicator: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.transparent,
                                          ),
                                          onTap: (int index) {
                                            controller.isIndex.value = index;
                                            if (index == 1) {}
                                          },
                                          tabs: [
                                            buildTab(
                                              "All",
                                              controller.isIndex.value == 0
                                                  ? Colors.white
                                                  : blueColor,
                                              controller.isIndex.value == 0
                                                  ? blueColor
                                                  : Colors.white,
                                            ),
                                            buildTab(
                                              "Speeches",
                                              controller.isIndex.value == 1
                                                  ? Colors.white
                                                  : blueColor,
                                              controller.isIndex.value == 1
                                                  ? blueColor
                                                  : Colors.white,
                                            ),
                                            buildTab(
                                              "Song",
                                              controller.isIndex.value == 2
                                                  ? Colors.white
                                                  : blueColor,
                                              controller.isIndex.value == 2
                                                  ? blueColor
                                                  : Colors.white,
                                            ),
                                          ]).paddingOnly(right: 100)),
                                  Expanded(
                                      child: TabBarView(
                                    controller: controller.mainController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: const [
                                      CategoryBuilder(),
                                      CategoryBuilder(),
                                      CategoryBuilder(),
                                    ],
                                  )),
                                ]),
                              )),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/home_view.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';

import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';
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
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 50, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(width: 0.5),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 240, 235, 235),
                                      blurRadius: 3.0,
                                      spreadRadius: 3),
                                ]),
                            child: Row(
                              children: [
                                svgWidget('assets/svg/music.svg'),
                                const SizedBox(
                                  width: 6,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    colorText('പാർട്ടി സമ്മേളനം', 16,
                                        fontWeight: FontWeight.w700),
                                    blackText('Minister A', 14,
                                        fontWeight: FontWeight.w500)
                                  ],
                                )
                              ],
                            ),
                          ),
                          blackText('Categories', 20,
                                  fontWeight: FontWeight.w700)
                              .paddingSymmetric(vertical: 20),
                          const CategoryCard(),
                        ],
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 0.5),
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
              colorText('പാർട്ടി സമ്മേളനം', 16, fontWeight: FontWeight.w700),
              blackText('Minister A', 14, fontWeight: FontWeight.w500),
            ],
          ),
          const Spacer(),
          blackText("4:24", 14)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/home_view.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';

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
                          SizedBox(
                              height: 40,
                              child: ListView.builder(
                                itemCount: 3,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Obx(() => CustomListTile(
                                        title: controller.option[index],
                                        onTap: () =>
                                            controller.selectItem(index),
                                        isSelected:
                                            controller.selectedIndex.value ==
                                                index,
                                      ));
                                },
                              )),
                          const CategoryCard(),

                          //  ListView.builder(
                          //     scrollDirection: Axis.horizontal,
                          //     itemCount: 3,
                          //     itemBuilder: (index, selectedIndex) {
                          //       return Padding(
                          //         padding: const EdgeInsets.all(5),
                          //         child: Container(
                          //           padding: EdgeInsets.all(8),
                          //           decoration: BoxDecoration(
                          //             color: Colors.white,
                          //             borderRadius: const BorderRadius.all(
                          //                 Radius.circular(25)),
                          //             border: Border.all(width: 0.5),
                          //           ),
                          //           height: selectedIndex == index ? 40 : 20,
                          //           child: blackText("All", 12),
                          //         ),
                          //       ) ;
                          //     }),

                          //    ListView.builder(
                          //       scrollDirection: Axis.horizontal,
                          //       itemCount: 3,
                          //       itemBuilder: (context, index) {
                          //         return Container(
                          //           padding: EdgeInsets.all(8),
                          //           child: blackText("All", 12),
                          //           decoration: BoxDecoration(
                          //             color: Colors.white,
                          //             borderRadius: const BorderRadius.all(
                          //                 Radius.circular(25)),
                          //             border: Border.all(width: 0.5),
                          //           ),
                          //         );
                          //       }),
                          // ),
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

class CustomListTile extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isSelected;

  CustomListTile({
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          decoration: BoxDecoration(
            gradient: isSelected
                ? primaryColor
                : const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.white, Colors.white],
                  ),
            // color: isSelected ? Colors.blue : Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            border: Border.all(width: 0.5),
          ),
          // height: selectedIndex == index ? 40 : 20,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );

    // ListTile(
    //   title:
    //   Text(
    //     title,
    //     style: TextStyle(
    //       color: isSelected
    //           ? Colors.blue
    //           : Colors.black, // Change color based on selection
    //     ),
    //   ),
    //   onTap: onTap as void Function()?,
    // );
  }
}

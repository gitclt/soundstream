import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/modules/home/controllers/home_controller.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';
import 'package:sound_stream_flutter_app/common_widgets/svg_widget/svg_widget.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';

class CategoryBuilder extends GetView<HomeController> {
  const CategoryBuilder({Key? key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.songDataList.length,
      itemBuilder: (context, index) {
        return const CategoryCard().paddingAll(3);
      },
    );
  }
}

class CategoryCard extends GetView<HomeController> {
  const CategoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.AUDIO);
      },
      child: Container(
        height: 60,
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
                blackText('പാർട്ടി സമ്മേളനം', 16, fontWeight: FontWeight.w700),
                colorText('Minister A', 14,
                    fontWeight: FontWeight.w500, color: Colors.grey),
              ],
            ),
            const Spacer(),
            blackText("4:24", 14)
          ],
        ),
      ),
    );
  }
}

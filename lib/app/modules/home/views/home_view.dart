import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/common_widgets/app_bar/home_appbar.dart';
import 'package:sound_stream_flutter_app/common_widgets/text/text.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppBar(label: 'Home AppBar'),
        body: Column(
          children: [
            blackText('Start your Trip \nto see all Features', 22,
                fontWeight: FontWeight.w700)
          ],
        ));
  }
}

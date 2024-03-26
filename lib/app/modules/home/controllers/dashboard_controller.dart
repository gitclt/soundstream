import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/home_start_view.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/home_view.dart';
import 'package:sound_stream_flutter_app/app/modules/profile/views/profile_view.dart';
import 'package:sound_stream_flutter_app/app/service/sessio.dart';

class DashboardController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxList<Widget> widgetOptions = <Widget>[
    Session.isCheckin == true ? const StartView() : const HomeView(),
    const ProfileView(),
  ].obs;

  final GlobalKey<ScaffoldState> dashboardScaffoldkey =
      GlobalKey<ScaffoldState>();

  void logOut() async {}
}

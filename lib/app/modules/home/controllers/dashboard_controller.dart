import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/home.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/home_view.dart';
import 'package:sound_stream_flutter_app/app/modules/profile/views/profile_view.dart';

class DashboardController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxList<Widget> widgetOptions = <Widget>[
    const HomeView(),
    // const SearchView(),
    const ProfileView(),
  ].obs;
  
  final GlobalKey<ScaffoldState> dashboardScaffoldkey =
      GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    super.onInit();
  }

  void logOut() async {}
}

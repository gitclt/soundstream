import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';
import 'dart:async';

import 'package:sound_stream_flutter_app/app/service/sessio.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () async {
      checkLoginStatus();
    });
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");

    String? locId = prefs.getString("location_id");
    String? userMobile = prefs.getString("mobile");

    if (id != null) {
      Session.vehId = id;
      Session.locId = locId.toString();
      Session.userMobile = userMobile.toString();

      Get.offAndToNamed(Routes.HOME);
    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }
}

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
    String? name = prefs.getString("name");
    String? vehicle = prefs.getString("vehicle");
    String? ischeckin = prefs.getString('checkin');
    String? place = prefs.getString('checkin_place');
    String? time = prefs.getString('checkin_time');
    String? lat = prefs.getString('lat');
    String? longi = prefs.getString('longi');
    String? date = prefs.getString('date');

    if (id != null) {
      Session.vehId = id;
      Session.locId = locId.toString();
      Session.userMobile = userMobile.toString();
      Session.userName = name.toString();
      Session.vehicle = vehicle.toString();
      ischeckin == "true" ? Session.isCheckin = true : false;
      Session.place = place.toString();
      Session.time = time.toString();
      Session.date = date.toString();
      Session.lati = lat.toString();
      Session.longi = longi.toString();
      if (Session.isCheckin == true) {
        Get.offAndToNamed(Routes.HOME_START);
      } else {
        Get.offAndToNamed(Routes.HOME);
      }
    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }
}

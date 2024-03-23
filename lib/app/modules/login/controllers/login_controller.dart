import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/api/api.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/toast.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  TextEditingController mobileController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  

  void login() async {
    isLoading(true);

    try {
      final response = await ApiProvider()
          .login(mobileController.text.trim(), vehicleController.text.trim());
      if (response != null) {
        if (response.success == true) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('id', response.data.first.id.toString());
          prefs.setString('location', response.data.first.location.toString());
          prefs.setString(
              'location_id', response.data.first.locationId.toString());
          prefs.setString('mobile', response.data.first.mobile.toString());
          prefs.setString("profile", jsonEncode(response.data));
          Get.offAllNamed(Routes.DATA_SYNCING, arguments: "");
        } else {
          isLoading(false);
          toast(response.message);
        }
      }
    } finally {
      isLoading(false);
    }
  }



  // getData() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   if (sharedPreferences.containsKey("profile")) {
  //     cartlist.value = List<Map<String, dynamic>>.from(
  //             jsonDecode(sharedPreferences.getString("profile")!))
  //         .map((x) => ListofItem.fromJson(x))
  //         .toList();
  //   }
  // }
}

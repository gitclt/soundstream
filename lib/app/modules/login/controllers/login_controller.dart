import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/api/api.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/toast.dart';
import 'package:sound_stream_flutter_app/app/model/song_model.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_stream_flutter_app/app/service/sessio.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  List<SongData> songdata = [];
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
          prefs.setString("name", response.data.first.name.toString());
          prefs.setString(
              "vehicle", response.data.first.vehicleName.toString());
          await getSongs(response.data.first.locationId.toString());
          Session.userMobile = response.data.first.vehicleName.toString();
          Session.userName = response.data.first.name.toString();
          Get.offAllNamed(
            Routes.SPLASH,
          );
        } else {
          isLoading(false);
          toast(response.message);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> getSongs(String locId) async {
    try {
      final response = await ApiProvider().getSong("", "", locId);
      if (response != null && response.success == true) {
        final prefs = await SharedPreferences.getInstance();

        List<Map<String, dynamic>> existingSongsJson =
            jsonDecode(prefs.getString("songsList") ?? '[]')
                .cast<Map<String, dynamic>>();

        for (var song in response.items.data) {
          String downloadPercentage = song.downloadPercentage.value;

          Map<String, dynamic> newSongData = {
            "id": song.id,
            "name": song.name,
            "remark": song.remark,
            "category_id": song.categoryId,
            "location_id": song.locationId,
            "file_name": song.fileName,
            "status": song.status,
            "created_at": song.createdAt,
            "updated_at": song.updatedAt,
            "created_by": song.createdBy,
            "updated_by": song.updatedBy,
            "assetLink": '',
            'downloadPercentage': downloadPercentage,
          };

          existingSongsJson.add(newSongData);
        }

        prefs.setString("songsList", jsonEncode(existingSongsJson));
      }
    } finally {}
  }
}

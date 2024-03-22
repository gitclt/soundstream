import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';
import 'package:sound_stream_flutter_app/constrains/app_color.dart';

class ProfileController extends GetxController {
  List<String> songDataList = [];

  @override
  void onInit() {
    getSongData();
    super.onInit();
  }

  getSongData() async {
    songDataList.clear();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("audioFilePaths")) {
      songDataList = sharedPreferences.getStringList('audioFilePaths') ?? [];
    }
  }

  Future<void> deleteFile(String filePath) async {
    try {
      File file = File(filePath);
      if (await file.exists() == true) {
        await file.delete();
      }
    } finally {}
  }

  Future<void> logout() async {
    dynamic returnResponse = await openDialog(
      "Do you want to logout",
      "Are you sure want to exit now?",
    );

    if (returnResponse == true) {
      for (var e in songDataList) {
        deleteFile(e);
      }
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Get.offAllNamed(Routes.SPLASH);
    }
  }

  Future<dynamic> openDialog(String title, String subTitle,
      {String? okRemark = 'Ok', String? cancelRemark = 'Cancel'}) {
    return Get.dialog(
      AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Text(
          title,
          textScaleFactor: .9,
        ),
        content: subTitle.isEmpty
            ? null
            : Text(
                subTitle,
                textScaleFactor: .9,
              ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => Get.back(result: false),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                  ),
                  child: Text(
                    cancelRemark!,
                    style: const TextStyle(color: blueColor, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                OutlinedButton(
                  onPressed: () {
                    Get.back(result: true);
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      okRemark!,
                      style: const TextStyle(fontSize: 15, color: blueColor),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

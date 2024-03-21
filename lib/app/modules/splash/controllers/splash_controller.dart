import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_stream_flutter_app/app/api/api.dart';
import 'package:sound_stream_flutter_app/app/api/base_url.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

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
    String? locid = prefs.getString("location_id");

    if (id != null) {
      await getSongs(locid.toString());
      Get.offAndToNamed(Routes.HOME);
    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }

  getSongs(String locId) async {
    try {
      final response = await ApiProvider().getSong("", "", locId);
      if (response != null) {
        if (response.success == true) {
          for (var e in response.items.data) {
            downloadAndSaveAudio(BaseUrl().audioUrl, e.fileName);
          }
        } else {}
      }
    } finally {}
  }

  Future<void> downloadAndSaveAudio(String url, String fileName) async {
    var audioUrl = "$url$fileName";
    var response = await http.get(Uri.parse(audioUrl));
    if (response.statusCode == 200) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/$fileName';
      var file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      await saveAudioFilePath(filePath);
    }
  }

  Future<void> saveAudioFilePath(String filePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> filePaths = prefs.getStringList('audioFilePaths') ?? [];
    filePaths.add(filePath);
    await prefs.setStringList('audioFilePaths', filePaths);
    prefs.setString("songs", jsonEncode(filePaths));
  }
}

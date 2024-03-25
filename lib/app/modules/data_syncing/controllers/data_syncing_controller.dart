import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_stream_flutter_app/app/api/api.dart';
import 'package:sound_stream_flutter_app/app/api/base_url.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:sound_stream_flutter_app/app/model/song_model.dart';

class DataSyncingController extends GetxController {
  List<SongData> songdata = [];
  List<String> songDataList = [];
  var isLoading = false.obs;
  var allSongsDownloaded = false.obs;
  String downlodPercntage = '';
  RxInt songnameIndex = 0.obs;
  final arg = Get.arguments;
  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? locid = prefs.getString("location_id");
    getSongs(locid.toString());
    super.onInit();
  }

  getSongs(String locId) async {
    isLoading(true);
    try {
      final response = await ApiProvider().getSong("", "", locId);
      if (response != null) {
        if (response.success == true) {
          songdata.addAll(response.items.data);
          isLoading(false);
          addSongsData(songdata);
          if (Get.arguments == "sync") {
            songDataList.clear();
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            if (sharedPreferences.containsKey("audioFilePaths")) {
              songDataList =
                  sharedPreferences.getStringList('audioFilePaths') ?? [];
            }
            for (var song in songdata) {
              var index = songDataList.indexWhere(
                  (element) => element.split("/").last == song.fileName);
              if (index != -1 && song.downloadPercentage.value != "100") {
                song.downloadPercentage.value = "100";
              }
            }
          }
          for (var e in songdata) {
            songnameIndex.value =
                songdata.indexWhere((song) => song.fileName == e.fileName);
            var currentSong = songdata[songnameIndex.value];
            if (e.downloadPercentage.value != "100") {
              await downloadAndSaveAudio(BaseUrl().audioUrl, e.fileName,
                  (double progress) {
                currentSong.downloadPercentage.value =
                    (progress * 100).toStringAsFixed(0);
              });
            }

            if (songdata.every((e) => e.downloadPercentage.value == '100')) {
              allSongsDownloaded.value = true;
            }
          }
        } else {}
      }
    } finally {}
  }

  Future<void> downloadAndSaveAudio(
      String url, String fileName, Function(double) onProgress) async {
    var audioUrl = "$url$fileName";
    var response = await http.get(Uri.parse(audioUrl));
    if (response.statusCode == 200) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/$fileName';
      var file = File(filePath);
      int totalBytes = response.contentLength ?? 0;
      int bytesDownloaded = 0;
      var sink = file.openWrite();
      sink.add(response.bodyBytes);
      bytesDownloaded += response.bodyBytes.length;
      double progress = bytesDownloaded / totalBytes;
      onProgress(progress);
      await sink.close();
      await saveAudioFilePath(filePath);
    }
  }

  Future<void> saveAudioFilePath(String filePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> filePaths = prefs.getStringList('audioFilePaths') ?? [];
    filePaths.add(filePath);
    await prefs.setStringList('audioFilePaths', filePaths);
  }

  double calculatePercentage(int songsWithFullDownload, int totalSongs) {
    if (songsWithFullDownload == 0) {
      return 0;
    } else {
      return (songsWithFullDownload / totalSongs) * 100;
    }
  }

  void addSongsData(List<SongData> songs) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(
        "songs",
        jsonEncode(songs
            .map((song) => {
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
                  "assetLink": "",
                  'downloadPercentage': song.downloadPercentage.value,
                })
            .toList()));
  }
}

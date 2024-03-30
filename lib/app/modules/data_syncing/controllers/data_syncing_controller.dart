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
  RxDouble prog = 0.0.obs;
  RxString status = "Not Downloaded".obs;

  // void startDownload(String url) async {
  //   progress.value = 0.000001;
  //   status.value = "Download Started";

  //   final request = http.Request('GET', Uri.parse(url));
  //   final response = await http.Client().send(request);
  //   final contentLength = response.contentLength;

  //   List<int> bytes = [];
  //   response.stream.listen(
  //     (List<int> newBytes) {
  //       bytes.addAll(newBytes);
  //       final downloadedLength = bytes.length;
  //       progress.value = downloadedLength.toDouble() / (contentLength ?? 1);
  //       status.value =
  //           "Progress: ${((progress.value ?? 0) * 100).toStringAsFixed(2)} %";
  //     },
  //     onDone: () async {
  //       progress.value = 1;
  //       status.value = "Download Finished";
  //       await saveFile(bytes, 'downloaded_file.mp4');
  //     },
  //     onError: (e) {
  //       status.value = "Error occurred during download";
  //     },
  //     cancelOnError: true,
  //   );
  // }

  // Future<void> saveFile(List<int> bytes, String filename) async {
  //   final dir = await getTemporaryDirectory();
  //   final file = File("${dir.path}/$filename");
  //   await file.writeAsBytes(bytes);
  //   // debugPrint("Downloaded file saved at: ${file.path}");
  // }

  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? locid = prefs.getString("location_id");
    getSongs(locid.toString());
    // startDownload('https://audiostream.gitzest.com/public/audios/KC_SONG_KADUVA.mp3');
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

          if (Get.arguments == "sync") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            List<Map<String, dynamic>> existingSongs =
                List<Map<String, dynamic>>.from(
                    jsonDecode(prefs.getString("songs") ?? '[]'));

            for (var song in songdata) {
              var index = existingSongs
                  .indexWhere((element) => element["id"] == song.id);
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
              }, e);
            }

            if (songdata.every((e) => e.downloadPercentage.value == '100')) {
              allSongsDownloaded.value = true;
            }
          }
        } else {}
      }
    } finally {}
  }

  Future<void> downloadAndSaveAudio(String url, String fileName,
      Function(double) onProgress, SongData song) async {
    prog.value = 0.000001;
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
      //       bytes.addAll(newBytes);
      final downloadedLength = response.bodyBytes.length;
      prog.value = downloadedLength.toDouble() / (response.contentLength ?? 1);
      double progress = bytesDownloaded / totalBytes;
      onProgress(progress);
      await sink.close();
      await saveAudioFilePath(filePath, song);
    }
  }

  Future<void> saveAudioFilePath(String filePath, SongData song) async {
    addSongsData(song, filePath);
  }

  double calculatePercentage(int songsWithFullDownload, int totalSongs) {
    if (songsWithFullDownload == 0) {
      return 0;
    } else {
      return (songsWithFullDownload / totalSongs) * 100;
    }
  }

  void addSongsData(SongData song, String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String downloadPercentage = song.downloadPercentage.value;

    List<Map<String, dynamic>> existingSongsJson = (prefs.getString("songs") !=
            null)
        ? List<Map<String, dynamic>>.from(jsonDecode(prefs.getString("songs")!))
        : [];

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
      "assetLink": path,
      'downloadPercentage': downloadPercentage,
    };

    existingSongsJson.add(newSongData);

    prefs.setString("songs", jsonEncode(existingSongsJson));
  }
}

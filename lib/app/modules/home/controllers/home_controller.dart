import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_stream_flutter_app/app/api/api.dart';
import 'package:sound_stream_flutter_app/app/common_widgets/toast.dart';
import 'package:sound_stream_flutter_app/app/model/checkin_model.dart';
import 'package:sound_stream_flutter_app/app/model/song_model.dart';
import 'package:sound_stream_flutter_app/app/modules/home/controllers/dashboard_controller.dart';
import 'package:sound_stream_flutter_app/app/modules/home/views/home_view.dart';
import 'package:sound_stream_flutter_app/app/modules/profile/views/profile_view.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';
import 'package:sound_stream_flutter_app/app/service/audio.dart';
import 'package:sound_stream_flutter_app/app/service/sessio.dart';
import 'package:sound_stream_flutter_app/common_widgets/popup/dialog_helper.dart';
import 'package:sound_stream_flutter_app/constrains/service/location.dart';
import 'package:intl/intl.dart';
import 'package:sound_stream_flutter_app/app/api/base_url.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController mainController;
  var selectedIndex = 0.obs;
  var songIndex = 0.obs;
  var isIndex = 0.obs;
  AudioPlayerService audioController = AudioPlayerService();
  var isLoading = false.obs;
  var isTripLoading = false.obs;
  var isCheckin = false.obs;
  var isaudioIndex = 0.obs;
  var isCheckOut = false.obs;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer audioPlayer1 = AudioPlayer();
  AudioPlayer audioPlayer2 = AudioPlayer();
  RxList<String> songDataList = <String>[].obs;

  List<String> catDataList = [];
  // List<SongModel> listofsong = [];
  List<String> candiateSong = [];
  List<CheckInData> checkInDataList = [];
  RxList<SongData> songdata = <SongData>[].obs;
  RxList<SongData> listsongdata = <SongData>[].obs;
  String downlodPercntage = '';
  RxInt songnameIndex = 0.obs;
  var allSongsDownloaded = false.obs;
  void selectItem(int index) {
    selectedIndex.value = index;
  }

  RxList<Widget> widgetOptions = <Widget>[
    const HomeView(),
    const ProfileView(),
  ].obs;

  @override
  void onInit() async {
    mainController = TabController(length: 4, vsync: this);
    getSongs();

    super.onInit();
  }

  final List<String> option = [
    'All',
    'Speeches',
    ' Songs',
  ];
  String place = '';
  String date = '';
  String time = '';
  String locality = '';
  DateTime datetime = DateTime.now();
  String crlatitude = '';
  String crlongitude = '';

  String formatDuration(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '${duration.inMinutes >= 60 ? '${duration.inMinutes ~/ 60}:' : ''}$minutes:$seconds';
  }

  void categoryFilter(String catId) {
    songdata.clear();
    if (catId == "") {
      songdata.addAll(listsongdata);
    } else {
      songdata
          .addAll(listsongdata.where((e) => e.categoryId.toString() == catId));
    }
  }

  getSongDetails() async {
    isLoading(true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey("songs")) {
      songdata.clear();
      songdata.value = List<Map<String, dynamic>>.from(
              jsonDecode(sharedPreferences.getString("songs")!))
          .map((x) => SongData.fromJson(x))
          .toList();
      listsongdata.value = List<Map<String, dynamic>>.from(
              jsonDecode(sharedPreferences.getString("songs")!))
          .map((x) => SongData.fromJson(x))
          .toList();

      candiateSong.addAll(
          songdata.where((e) => e.categoryId == 3).map((e) => e.assetLink));
    }
    isLoading(false);
  }

  Future<bool> getCurrentPos(Position position) async {
    try {
      crlatitude = position.latitude.toString();
      crlongitude = position.longitude.toString();

      List<Placemark> coordinates = await placemarkFromCoordinates(
          double.parse(crlatitude), double.parse(crlongitude));

      Placemark geoAddress = coordinates.first;
      place = geoAddress.locality!;
      locality = geoAddress.subLocality!;

      return true;
    } catch (e) {
      return false;
    }
  }

  dateToFormatted(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }

  timeFormatted(DateTime dateTime) {
    return DateFormat("HH:mm").format(dateTime);
  }

  Future<void> fetchLocation() async {
    DialogHelper.showLoading("Fetching Location ...");
    final location = await determinePosition();
    DialogHelper.hideLoading();
    if (location == null) return;

    final locStatus = await getCurrentPos(location);

    if (!locStatus) return;
    markCheckIn(Session.vehId, Session.locId, dateToFormatted(datetime),
        timeFormatted(datetime), place, crlatitude, crlongitude);
  }

  Future<void> markCheckIn(
    String vehId,
    String locId,
    String date,
    String time,
    String place,
    String lat,
    String longi,
  ) async {
    DialogHelper.showLoading("Please wait while marking Check In...");
    try {
      final response = await ApiProvider()
          .checkInVisit(vehId, locId, date, time, place, lat, longi);
      if (response != null) {
        if (response.success == true) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('checkin', "true");
          prefs.setString('checkin_place', place);
          prefs.setString('checkin_time', time);
          prefs.setString('lat', crlatitude);
          prefs.setString('longi', crlongitude);
          prefs.setString('date', date);
          Session.isCheckin = true;
          Session.place = place;
          Session.time = timeFormatted(datetime);
          Session.date = date;
          Session.lati = lat;
          Session.longi = longi;
          // getSongDetails();
          DialogHelper.hideLoading();
          toast("Checkin Sucessfully");
          final DashboardController dashcontroller = Get.find();
          dashcontroller.updateWidgetOptions(true);
          // Get.offAndToNamed(Routes.HOME);
        } else {
          DialogHelper.hideLoading();
          toast(response.message);
        }
      } else {
        toast("Checkin Sucessfully");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('checkin', "true");
        prefs.setString('checkin_place', place);
        prefs.setString('checkin_time', time);
        prefs.setString('lat', crlatitude);
        prefs.setString('longi', crlongitude);
        prefs.setString('date', date);
        DialogHelper.hideLoading();
        Session.isCheckin = true;
        Session.place = place;
        Session.time = timeFormatted(datetime);
        Session.date = date;
        Session.lati = lat;
        Session.longi = longi;
        // getSongDetails();
        final DashboardController dashcontroller = Get.find();
        dashcontroller.updateWidgetOptions(true);
        // Get.offAndToNamed(Routes.HOME);
        // Get.offAndToNamed(Routes.HOME);
      }
    } finally {
      DialogHelper.hideLoading();
    }
  }

  Future<void> getCheckIn() async {
    try {
      final response = await ApiProvider()
          .getCheckIn(Session.vehId, dateToFormatted(datetime));
      if (response != null) {
        if (response.success == true) {
          DialogHelper.showLoading("Fetching Location ...");
          final location = await determinePosition();
          DialogHelper.hideLoading();
          if (location == null) return;

          final locStatus = await getCurrentPos(location);

          if (!locStatus) return;
          String duration = calculateDurationBetween(
              response.data.first.checkInTime, timeFormatted(datetime));
          getCheckOutMarkVisit(
              response.data.first.id.toString(),
              timeFormatted(datetime),
              place,
              crlatitude,
              crlongitude,
              duration);
        } else if (response.success == false) {}
      } else {
        toast("No internet");
      }
    } finally {}
  }

  String calculateDurationBetween(String startTimeStr, String endTimeStr) {
    List<int> startTimeParts = startTimeStr.split(':').map(int.parse).toList();
    List<int> endTimeParts = endTimeStr.split(':').map(int.parse).toList();
    DateTime startTime = DateTime(
      0,
      1,
      1,
      startTimeParts[0],
      startTimeParts[1],
    );
    DateTime endTime = DateTime(
      0,
      1,
      1,
      endTimeParts[0],
      endTimeParts[1],
    );
    Duration duration = endTime.difference(startTime);
    String formattedDuration =
        '${duration.inHours}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return formattedDuration;
  }

  Future<void> getCheckOutMarkVisit(
    String id,
    String time,
    String place,
    String lat,
    String longi,
    String duration,
  ) async {
    isCheckOut(true);
    try {
      final response = await ApiProvider()
          .checkOutVisit(id, time, place, lat, longi, duration);
      if (response != null) {
        if (response.success == true) {
          toast("Sucessfully Checkout");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('checkin', "false");
          prefs.setString('checkin_place', "");
          prefs.setString('checkin_time', "");
          prefs.setString('lat', "");
          prefs.setString('longi', "");
          prefs.setString('date', "");
          isCheckin.value = false;
          Session.isCheckin = false;
          Session.place = "";
          Session.time = "";
          audioPlayer.stop();
          audioPlayer1.stop();
          audioPlayer2.stop();
          getTripDetails();
        }
      } else {
        toast("Checkout Unsucessfull");
      }
    } finally {
      isCheckOut(false);
    }
  }

  Future<void> getTripDetails() async {
    isTripLoading(true);
    try {
      final response = await ApiProvider()
          .getCheckIn(Session.vehId, dateToFormatted(datetime));
      if (response != null) {
        if (response.success == true) {
          checkInDataList.addAll(response.data);
          Get.back();
          Get.offAndToNamed(Routes.HOME_END);
        }
      }
    } finally {
      isTripLoading(false);
    }
  }

  void setPlayingAtIndex(int index) {
    SongData songToPlay = songdata[index];

    for (int i = 0; i < listsongdata.length; i++) {
      if (listsongdata[i].id == songToPlay.id) {
        listsongdata[i].isPlaying = true;
      } else {
        listsongdata[i].isPlaying = false;
      }
    }
  }

  double calculatePercentage(int songsWithFullDownload, int totalSongs) {
    if (songsWithFullDownload == 0) {
      return 0;
    } else {
      return (songsWithFullDownload / totalSongs) * 100;
    }
  }

  RxList<SongData> songsList = <SongData>[].obs;
  getSongs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    songsList.value = (jsonDecode(prefs.getString("songsList")!) as List)
        .map((x) => SongData.fromJson(x))
        .toList();
    listsongdata.addAll(songsList);
    songdata.addAll(songsList);
    if (songsList.isNotEmpty) {
      for (var e in songsList) {
        List<Map<String, dynamic>> existingSongs =
            List<Map<String, dynamic>>.from(
                jsonDecode(prefs.getString("songs") ?? '[]'));

        for (var song in songsList) {
          var index =
              existingSongs.indexWhere((element) => element["id"] == song.id);
          if (index != -1 && song.downloadPercentage.value != "100") {
            song.downloadPercentage.value = "100";
          }
        }
        if (Session.isCheckin == true) {
          if (listsongdata.every((e) => e.assetLink != "")) {
            getSongDetails();
          } else if (listsongdata
              .any((e) => e.downloadPercentage.value != "100")) {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            RxList<SongData> newlyaddedsongdata = <SongData>[].obs;
            newlyaddedsongdata.value = List<Map<String, dynamic>>.from(
                    jsonDecode(sharedPreferences.getString("songs")!))
                .map((x) => SongData.fromJson(x))
                .toList();

            for (var e in newlyaddedsongdata) {
              if (e.assetLink != "") {
                int id = e.id;
                var matchingSong = listsongdata.firstWhere(
                  (song) => song.id == id,
                );
                matchingSong.assetLink = e.assetLink;
              }
              if (e.categoryId == 3) {
                isLoading(true);
                candiateSong.add(e.assetLink);
                isLoading(false);
              }
            }
          } else if (listsongdata
              .every((e) => e.downloadPercentage.value == "100")) {
            getSongDetails();
          }
        }
        songnameIndex.value =
            songsList.indexWhere((song) => song.fileName == e.fileName);
        var currentSong = songsList[songnameIndex.value];

        if (e.downloadPercentage.value != "100") {
          await downloadAndSaveAudio(BaseUrl().audioUrl, e.fileName,
              (double progress) {
            currentSong.downloadPercentage.value = progress.toStringAsFixed(0);
          }, e);
        }

        if (songdata.every((e) => e.downloadPercentage.value == '100')) {
          allSongsDownloaded.value = true;
        }
      }
    }
  }

  // Future<void> downloadAndSaveAudio(String url, String fileName,
  //     Function(double) onProgress, SongData song) async {
  //   var audioUrl = "$url$fileName";
  //   var response = await http.get(Uri.parse(audioUrl));
  //   if (response.statusCode == 200) {
  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     String filePath = '${appDocDir.path}/$fileName';
  //     var file = File(filePath);
  //     int totalBytes = response.contentLength ?? 0;
  //     int bytesDownloaded = 0;
  //     var sink = file.openWrite();
  //     sink.add(response.bodyBytes);
  //     bytesDownloaded += response.bodyBytes.length;
  //     double progress = bytesDownloaded / totalBytes;
  //     onProgress(progress);
  //     await sink.close();
  //     await saveAudioFilePath(filePath, song);
  //   }
  // }

  Future<void> downloadAndSaveAudio(String url, String fileName,
      Function(double) onProgress, SongData song) async {
    var audioUrl = "$url$fileName";
    final client = http.Client();
    http.StreamedResponse response =
        await client.send(http.Request("GET", Uri.parse(audioUrl)));
    if (response.statusCode == 200) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/$fileName';
      var file = File(filePath);
      var length = response.contentLength ?? 0;
      var received = 0;
      var sink = file.openWrite();
      await response.stream.map((s) {
        received += s.length;
        var progress = (received / length) * 100;
        onProgress(progress);
        return s;
      }).pipe(sink);

      await saveAudioFilePath(filePath, song);
    }
  }

  Future<void> saveAudioFilePath(String filePath, SongData song) async {
    addSongsData(song, filePath);
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

    // getSongDetails();
    for (var existingSong in songdata) {
      if (existingSong.id == song.id) {
        existingSong.assetLink = path;
        update();
        songdata.refresh();
      }
    }
    for (var existingSong in listsongdata) {
      if (existingSong.id == song.id) {
        existingSong.assetLink = path;
        update();
        listsongdata.refresh();
      }
    }
    candiateSongadd(song, path);
  }

  candiateSongadd(SongData sdata, String path) {
    isLoading(true);
    if (sdata.categoryId == 3) {
      candiateSong.add(path);
    }

    isLoading(false);
  }
}

class SongModel {
  final String link;
  final String name;
  SongModel(
    this.link,
    this.name,
  );
}

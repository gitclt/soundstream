import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:sound_stream_flutter_app/app/model/song_model.dart';

class LocationService {
  Timer? timer;
  void sendLocation() {
    Geolocator.getPositionStream().listen((Position position) {
      Timer.periodic(const Duration(minutes: 5), (timer) async {
        Position position = await Geolocator.getCurrentPosition();

        print('Sending location: ${position.latitude}, ${position.longitude}');
      });
    });
  }

  void checkLocation(RxList<SongData> songdata) {
    Geolocator.getPositionStream().listen((Position position) {
      Timer.periodic(const Duration(seconds: 25), (timer) async {
        Position position = await Geolocator.getCurrentPosition();
        List<String> songsToRemove =
            getNearbySongs(position.latitude, position.longitude);
        print(songsToRemove);
        //  songdata.removeWhere((song) => songsToRemove.contains(song.location));
      });
    });
  }

  void cancelTimer() {
    timer?.cancel();
    timer = null;
  }
}

// Define the predefined locations
List<Location> predefinedLocations = [
  Location("nadakkavu", 37.4219983, -122.084),
];

class Location {
  final String name;
  final double latitude;
  final double longitude;

  Location(this.name, this.latitude, this.longitude);
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const p = 0.017453292519943295;
  final a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

List<String> getNearbySongs(double currentLatitude, double currentLongitude) {
  List<String> songsToRemove = [];

  for (var location in predefinedLocations) {
    double distance = calculateDistance(currentLatitude, currentLongitude,
        location.latitude, location.longitude);

    if (distance < 5) {
      songsToRemove.add(location.name);
    }
  }

  return songsToRemove;
}

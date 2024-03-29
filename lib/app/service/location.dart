import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationService {
  void sendLocation() {
    Geolocator.getPositionStream().listen((Position position) {
      Timer.periodic(const Duration(minutes: 5), (Timer timer) async {
        Position position = await Geolocator.getCurrentPosition();

        print('Sending location: ${position.latitude}, ${position.longitude}');
      });
    });
  }
}

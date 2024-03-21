import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:sound_stream_flutter_app/app/api/http_provider.dart';
import 'package:sound_stream_flutter_app/app/model/model.dart';
import 'package:sound_stream_flutter_app/app/model/song_model.dart';

class ApiProvider {
  Future<LoginResponse?> login(
    String mobile,
    String vehicleNo,
  ) async {
    try {
      final response = await HttpApiConnect()
          .httpGetApi("vehicle_login?mobile=$mobile&vehicle_no=$vehicleNo");

      if (response.statusCode == 200) {
        var data = response.body;
        return LoginResponse?.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<LoginResponse?> getProfile(String mobile) async {
    try {
      final response =
          await HttpApiConnect().httpGetApi("vehicle_profile?mobile=$mobile");

      if (response.statusCode == 200) {
        var data = response.body;
        return LoginResponse?.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<SongModel?> getSong(String catId, String keyword, String locId) async {
    try {
      final response = await HttpApiConnect().httpGetApi(
          "items?cat_id=$catId&keyword=$keyword&location_id=$locId");

      if (response.statusCode == 200) {
        var data = response.body;
        return SongModel?.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

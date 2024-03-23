import 'dart:convert';
import 'package:sound_stream_flutter_app/app/api/http_provider.dart';
import 'package:sound_stream_flutter_app/app/model/api_model.dart';
import 'package:sound_stream_flutter_app/app/model/checkin_model.dart';
import 'package:sound_stream_flutter_app/app/model/model.dart';
import 'package:sound_stream_flutter_app/app/model/song_model.dart';

class ApiProvider {
  Future<LoginResponse?> login(
    String mobile,
    String vehicleNo,
  ) async {
    try {
      final response = await HttpApiConnect()
          .getApi("vehicle_login?mobile=$mobile&vehicle_no=$vehicleNo");

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
          await HttpApiConnect().getApi("vehicle_profile?mobile=$mobile");

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
      final response = await HttpApiConnect()
          .getApi("items?cat_id=$catId&keyword=$keyword&location_id=$locId");

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

  Future<ApiModel?> checkInVisit(
    String vehId,
    String locId,
    String date,
    String time,
    String place,
    String lat,
    String longi,
  ) async {
    var add = {
      "location_id": locId,
      "date": date,
      "check_in_time": time,
      "check_in_location": place,
      "check_in_lat": lat,
      "check_in_log": longi
    };
    var response = await HttpApiConnect().post("check_in", add);

    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return ApiModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ApiModel?> checkOutVisit(
    String id,
    String time,
    String place,
    String lat,
    String longi,
    String duration,
  ) async {
    var add = {
      "id": id,
      "check_out_time": time,
      "check_out_location": place,
      "check_out_lat": lat,
      "check_out_log": longi,
      "duration": duration
    };
    var response = await HttpApiConnect().post("check_out", add);

    try {
      if (response.statusCode == 200) {
        var data = response.body;
        return ApiModel.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<CheckInModel?> getCheckIn(
    String vehId,
    String date,
  ) async {
    try {
      final response = await HttpApiConnect()
          .getApi("getVehicleCheckin?vehicle_id=$vehId&date=$date");

      if (response.statusCode == 200) {
        var data = response.body;
        return CheckInModel?.fromJson(json.decode(data));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

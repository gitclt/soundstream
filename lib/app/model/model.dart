
import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool success;
  List<ProfileData> data;
  String message;

  LoginResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        data: List<ProfileData>.from(
            json["data"].map((x) => ProfileData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class ProfileData {
  int id;
  String name;
  String district;
  String vehicleNo;
  String vehicleName;
  String mobile;
  int locationId;
  int status;
  int stateId;
  int periodId;
  String location;
  String districtId;

  String createdAt;
  String updatedAt;

  ProfileData({
    required this.id,
    required this.name,
    required this.district,
    required this.vehicleNo,
    required this.vehicleName,
    required this.mobile,
    required this.locationId,
    required this.status,
    required this.stateId,
    required this.periodId,
    required this.location,
    required this.districtId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json["id"],
        name: json["name"],
        district: json["district"],
        vehicleNo: json["vehicle_no"],
        vehicleName: json["vehicle_name"],
        mobile: json["mobile"],
        locationId: json["location_id"],
        status: json["status"],
        stateId: json["state_id"],
        periodId: json["period_id"],
        location: json["location"],
        districtId: json["district_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "district": district,
        "vehicle_no": vehicleNo,
        "vehicle_name": vehicleName,
        "mobile": mobile,
        "location_id": locationId,
        "status": status,
        "state_id": stateId,
        "period_id": periodId,
        "location": location,
        "district_id": districtId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

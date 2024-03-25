import 'dart:convert';

CheckInModel checkInModelFromJson(String str) =>
    CheckInModel.fromJson(json.decode(str));

String checkInModelToJson(CheckInModel data) => json.encode(data.toJson());

class CheckInModel {
  bool success;
  String message;
  List<CheckInData> data;

  CheckInModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CheckInModel.fromJson(Map<String, dynamic> json) => CheckInModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CheckInData>.from(
                json["data"].map((x) => CheckInData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CheckInData {
  int id;
  int vehicleId;
  int locationId;
  String date;
  String checkInTime;
  String checkInLocation;
  double checkInLat;
  double checkInLog;
  String checkOutTime;
  String checkOutLocation;
  double checkOutLat;
  double checkOutLog;
  String duration;
  String createdAt;
  dynamic updatedAt;
  dynamic createdBy;
  dynamic updatedBy;

  CheckInData({
    required this.id,
    required this.vehicleId,
    required this.locationId,
    required this.date,
    required this.checkInTime,
    required this.checkInLocation,
    required this.checkInLat,
    required this.checkInLog,
    required this.checkOutTime,
    required this.checkOutLocation,
    required this.checkOutLat,
    required this.checkOutLog,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
  });

  factory CheckInData.fromJson(Map<String, dynamic> json) => CheckInData(
        id: json["id"],
        vehicleId: json["vehicle_id"],
        locationId: json["location_id"],
        date: json["date"] ?? "",
        checkInTime: json["check_in_time"] ?? "",
        checkInLocation: json["check_in_location"],
        checkInLat: json["check_in_lat"] ?? 0,
        checkInLog: json["check_in_log"] ?? 0,
        checkOutTime: json["check_out_time"] ?? "",
        checkOutLocation: json["check_out_location"] ?? "",
        checkOutLat: json["check_out_lat"] ?? 0,
        checkOutLog: json["check_out_log"] ?? 0,
        duration: json["duration"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        createdBy: json["created_by"] ?? "",
        updatedBy: json["updated_by"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle_id": vehicleId,
        "location_id": locationId,
        "date": date,
        "check_in_time": checkInTime,
        "check_in_location": checkInLocation,
        "check_in_lat": checkInLat,
        "check_in_log": checkInLog,
        "check_out_time": checkOutTime,
        "check_out_location": checkOutLocation,
        "check_out_lat": checkOutLat,
        "check_out_log": checkOutLog,
        "duration": duration,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "created_by": createdBy,
        "updated_by": updatedBy,
      };
}

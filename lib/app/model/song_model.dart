import 'dart:convert';

import 'package:get/get.dart';

SongModel songModelFromJson(String str) => SongModel.fromJson(json.decode(str));

String songModelToJson(SongModel data) => json.encode(data.toJson());

class SongModel {
  bool success;
  String message;
  SongItems items;

  SongModel({
    required this.success,
    required this.message,
    required this.items,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
        success: json["success"],
        message: json["message"],
        items: SongItems.fromJson(json["items"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "items": items.toJson(),
      };
}

class SongItems {
  int currentPage;
  List<SongData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  SongItems({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory SongItems.fromJson(Map<String, dynamic> json) => SongItems(
        currentPage: json["current_page"],
        data:
            List<SongData>.from(json["data"].map((x) => SongData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class SongData {
  int id;
  String name;
  String remark;
  int categoryId;
  int locationId;
  String fileName;
  int status;
  String createdAt;
  String updatedAt;
  int createdBy;
  int updatedBy;
  String assetLink;
  RxString downloadPercentage;

  SongData({
    required this.id,
    required this.name,
    required this.remark,
    required this.categoryId,
    required this.locationId,
    required this.fileName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.assetLink,
    required this.downloadPercentage,
  });

  factory SongData.fromJson(Map<String, dynamic> json) => SongData(
        id: json["id"],
        name: json["name"],
        remark: json["remark"],
        categoryId: json["category_id"],
        locationId: json["location_id"],
        fileName: json["file_name"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        assetLink: json["assetLink"] ?? "",
        downloadPercentage: "".obs,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "remark": remark,
        "category_id": categoryId,
        "location_id": locationId,
        "file_name": fileName,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "assetLink": assetLink,
        "downloadPercentage": downloadPercentage
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

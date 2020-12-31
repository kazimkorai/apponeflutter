// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SpecificProfileDetails welcomeFromJson(String str) => SpecificProfileDetails.fromJson(json.decode(str));

String welcomeToJson(SpecificProfileDetails data) => json.encode(data.toJson());

class SpecificProfileDetails {
  SpecificProfileDetails({
    this.statusCode,
    this.data,
  });

  int statusCode;
  Data data;

  factory SpecificProfileDetails.fromJson(Map<String, dynamic> json) => SpecificProfileDetails(
    statusCode: json["status_code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.userId,
    this.profileName,
    this.profileEmail,
    this.profilePhone,
    this.profileAddress,
    this.profileWebsite,
    this.profileAbout,
    this.profileType,
    this.profileStatus,
    this.notificationStatus,
    this.createdAt,
    this.cityId,
    this.cityName,
    this.countryId,
    this.countryName,
    this.profileImage,
    this.category,
  });

  var id;
  var userId;
  String profileName;
  String profileEmail;
  String profilePhone;
  String profileAddress;
  String profileWebsite;
  String profileAbout;
  String profileType;
  String profileStatus;
  String notificationStatus;
  var createdAt;
  var cityId;
  String cityName;
  var countryId;
  String countryName;
  String profileImage;
  List<Category> category;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    profileName: json["profile_name"],
    profileEmail: json["profile_email"],
    profilePhone: json["profile_phone"],
    profileAddress: json["profile_address"],
    profileWebsite: json["profile_website"],
    profileAbout: json["profile_about"],
    profileType: json["profile_type"],
    profileStatus: json["profile_status"],
    notificationStatus: json["notification_status"],
    createdAt: DateTime.parse(json["created_at"]),
    cityId: json["city_id"],
    cityName: json["city_name"],
    countryId: json["country_id"],
    countryName: json["country_name"],
    profileImage: json["profile_image"],
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "profile_name": profileName,
    "profile_email": profileEmail,
    "profile_phone": profilePhone,
    "profile_address": profileAddress,
    "profile_website": profileWebsite,
    "profile_about": profileAbout,
    "profile_type": profileType,
    "profile_status": profileStatus,
    "notification_status": notificationStatus,
    "created_at": createdAt.toIso8601String(),
    "city_id": cityId,
    "city_name": cityName,
    "country_id": countryId,
    "country_name": countryName,
    "profile_image": profileImage,
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.categoryId,
    this.categoryName,
  });

  int categoryId;
  int categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
  };
}

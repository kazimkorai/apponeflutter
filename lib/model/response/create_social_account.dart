// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CreateSocialAccount welcomeFromJson(String str) => CreateSocialAccount.fromJson(json.decode(str));

String welcomeToJson(CreateSocialAccount data) => json.encode(data.toJson());

class CreateSocialAccount {
  CreateSocialAccount({
    this.statusCode,
    this.data,
  });

  int statusCode;
  Data data;

  factory CreateSocialAccount.fromJson(Map<String, dynamic> json) => CreateSocialAccount(
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
    this.userId,
    this.countryId,
    this.cityId,
    this.profileName,
    this.profileEmail,
    this.profileImage,
    this.profilePhone,
    this.profileAddress,
    this.profileWebsite,
    this.profileAbout,
    this.profileBanner,
    this.profileType,
    this.profileStatus,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  var userId;
  var countryId;
  var cityId;
  String profileName;
  String profileEmail;
  String profileImage;
  String profilePhone;
  String profileAddress;
  String profileWebsite;
  String profileAbout;
  String profileBanner;
  String profileType;
  var profileStatus;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    countryId: json["country_id"],
    cityId: json["city_id"],
    profileName: json["profile_name"],
    profileEmail: json["profile_email"],
    profileImage: json["profile_image"],
    profilePhone: json["profile_phone"],
    profileAddress: json["profile_address"],
    profileWebsite: json["profile_website"],
    profileAbout: json["profile_about"],
    profileBanner: json["profile_banner"],
    profileType: json["profile_type"],
    profileStatus: json["profile_status"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "country_id": countryId,
    "city_id": cityId,
    "profile_name": profileName,
    "profile_email": profileEmail,
    "profile_image": profileImage,
    "profile_phone": profilePhone,
    "profile_address": profileAddress,
    "profile_website": profileWebsite,
    "profile_about": profileAbout,
    "profile_banner": profileBanner,
    "profile_type": profileType,
    "profile_status": profileStatus,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LoginDataModel welcomeFromJson(String str) => LoginDataModel.fromJson(json.decode(str));

String welcomeToJson(LoginDataModel data) => json.encode(data.toJson());

class LoginDataModel {
  LoginDataModel({
    this.statusCode,
    this.data,
  });

  int statusCode;
  Data data;

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
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
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.dateOfBirth,
    this.address,
    this.about,
    this.profilePhotoPath,
    this.userProfileId,
    this.profileName,
    this.profileEmail,
    this.profileAddress,
    this.profileStatus,
    this.createdAt,
    this.profileImage,
    this.userCountryId,
    this.userCountryName,
    this.userCityId,
    this.userCityName,
    this.token,
  });

  int userId;
  String name;
  String email;
  String phone;
  String gender;
  String dateOfBirth;
  String address;
  String about;
  String profilePhotoPath;
  var userProfileId;
  var profileName;
  var profileEmail;
  var profileAddress;
  var profileStatus;
  String createdAt;
  String profileImage;
  int userCountryId;
  String userCountryName;
  int userCityId;
  String userCityName;
  String token;


/*  "user_profile_id": null,
  "profile_name": null,
  "profile_email": null,
  "profile_address": null,
  "profile_status": null,
  "created_at": null,*/

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    gender: json["gender"],
    dateOfBirth: json["date_of_birth"],
    address: json["address"],
    about: json["about"],
    profilePhotoPath: json["profile_photo_path"],
    userProfileId: json["user_profile_id"],
    profileName: json["profile_name"],
    profileEmail: json["profile_email"],
    profileAddress: json["profile_address"],
    profileStatus: json["profile_status"],
    createdAt: json["created_at"],
    profileImage: json["profile_image"],
    userCountryId: json["user_country_id"],
    userCountryName: json["user_country_name"],
    userCityId: json["user_city_id"],
    userCityName: json["user_city_name"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "email": email,
    "phone": phone,
    "gender": gender,
    "date_of_birth": dateOfBirth,
    "address": address,
    "about": about,
    "profile_photo_path": profilePhotoPath,
    "user_profile_id": userProfileId,
    "profile_name": profileName,
    "profile_email": profileEmail,
    "profile_address": profileAddress,
    "profile_status": profileStatus,
    "created_at": createdAt,
    "profile_image": profileImage,
    "user_country_id": userCountryId,
    "user_country_name": userCountryName,
    "user_city_id": userCityId,
    "user_city_name": userCityName,
    "token": token,
  };
}

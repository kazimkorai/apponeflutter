// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

VerifyRecoveryCode welcomeFromJson(String str) => VerifyRecoveryCode.fromJson(json.decode(str));

String welcomeToJson(VerifyRecoveryCode data) => json.encode(data.toJson());

class VerifyRecoveryCode {
  VerifyRecoveryCode({
    this.statusCode,
    this.data,
  });

  int statusCode;
  Data data;

  factory VerifyRecoveryCode.fromJson(Map<String, dynamic> json) => VerifyRecoveryCode(
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
    this.email,
    this.password,
  });

  var userId;
  String email;
  String password;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "email": email,
    "password": password,
  };
}

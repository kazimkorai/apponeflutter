// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ForgotDataModel welcomeFromJson(String str) => ForgotDataModel.fromJson(json.decode(str));

String welcomeToJson(ForgotDataModel data) => json.encode(data.toJson());

class ForgotDataModel {
  ForgotDataModel({
    this.statusCode,
    this.message,
  });

  int statusCode;
  String message;

  factory ForgotDataModel.fromJson(Map<String, dynamic> json) => ForgotDataModel(
    statusCode: json["status_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
  };
}

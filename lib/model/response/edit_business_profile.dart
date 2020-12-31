// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

EditBuisnessProfileRes welcomeFromJson(String str) => EditBuisnessProfileRes.fromJson(json.decode(str));

String welcomeToJson(EditBuisnessProfileRes data) => json.encode(data.toJson());

class EditBuisnessProfileRes {
  EditBuisnessProfileRes({
    this.statusCode,
    this.data,
  });

  int statusCode;
  String data;

  factory EditBuisnessProfileRes.fromJson(Map<String, dynamic> json) => EditBuisnessProfileRes(
    statusCode: json["status_code"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "data": data,
  };
}

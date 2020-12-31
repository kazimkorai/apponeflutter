// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AboutUsSettings welcomeFromJson(String str) => AboutUsSettings.fromJson(json.decode(str));

String welcomeToJson(AboutUsSettings data) => json.encode(data.toJson());

class AboutUsSettings {
  AboutUsSettings({
    this.statusCode,
    this.data,
  });

  int statusCode;
  Data data;

  factory AboutUsSettings.fromJson(Map<String, dynamic> json) => AboutUsSettings(
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
    this.sideBar,
  });

  List<SideBar> sideBar;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sideBar: List<SideBar>.from(json["side_bar"].map((x) => SideBar.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "side_bar": List<dynamic>.from(sideBar.map((x) => x.toJson())),
  };
}

class SideBar {
  SideBar({
    this.sidebarId,
    this.sidebarName,
    this.createdAt,
    this.content,
    this.aboutUsImages,
  });

  int sidebarId;
  String sidebarName;
  String createdAt;
  String content;
  List<AboutUsImage> aboutUsImages;

  factory SideBar.fromJson(Map<String, dynamic> json) => SideBar(
    sidebarId: json["sidebar_id"],
    sidebarName: json["sidebar_name"],
    createdAt: json["created_at"],
    content: json["content"],
    aboutUsImages: List<AboutUsImage>.from(json["about_us_images"].map((x) => AboutUsImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sidebar_id": sidebarId,
    "sidebar_name": sidebarName,
    "created_at": createdAt,
    "content": content,
    "about_us_images": List<dynamic>.from(aboutUsImages.map((x) => x.toJson())),
  };
}

class AboutUsImage {
  AboutUsImage({
    this.imageId,
    this.toturialType,
    this.image,
  });

  int imageId;
  String toturialType;
  String image;

  factory AboutUsImage.fromJson(Map<String, dynamic> json) => AboutUsImage(
    imageId: json["image_id"],
    toturialType: json["toturial_type"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image_id": imageId,
    "toturial_type": toturialType,
    "image": image,
  };
}

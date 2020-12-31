// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Intrests welcomeFromJson(String str) => Intrests.fromJson(json.decode(str));

String welcomeToJson(Intrests data) => json.encode(data.toJson());

class Intrests {
  Intrests({
    this.statusCode,
    this.data,
  });

  int statusCode;
  Data data;

  factory Intrests.fromJson(Map<String, dynamic> json) => Intrests(
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
    this.category,
    this.hashtag,
    this.topics,
  });

  List<Category> category;
  List<Category> hashtag;
  List<Category> topics;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    hashtag: List<Category>.from(json["hashtag"].map((x) => Category.fromJson(x))),
    topics: List<Category>.from(json["topics"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
    "hashtag": List<dynamic>.from(hashtag.map((x) => x.toJson())),
    "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.image,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  dynamic image;
  Status status;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    status: statusValues.map[json["status"]],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "status": statusValues.reverse[status],
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

enum Status { PUBLISH, STATUS_PUBLISH }

final statusValues = EnumValues({
  "publish": Status.PUBLISH,
  "Publish": Status.STATUS_PUBLISH
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

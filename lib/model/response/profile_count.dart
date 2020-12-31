// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProfileCount welcomeFromJson(String str) => ProfileCount.fromJson(json.decode(str));

String welcomeToJson(ProfileCount data) => json.encode(data.toJson());

class ProfileCount {
  ProfileCount({
    this.statusCode,
    this.data,
  });

  int statusCode;
  Data data;

  factory ProfileCount.fromJson(Map<String, dynamic> json) => ProfileCount(
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
    this.socialCount,
    this.socialProfiles,
    this.buisnessCount,
    this.buisnessProfiles,
  });

  int socialCount;
  List<Profile> socialProfiles;
  int buisnessCount;
  List<Profile> buisnessProfiles;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    socialCount: json["social_count"],
    socialProfiles: List<Profile>.from(json["social_profiles"].map((x) => Profile.fromJson(x))),
    buisnessCount: json["buisness_count"],
    buisnessProfiles: List<Profile>.from(json["buisness_profiles"].map((x) => Profile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "social_count": socialCount,
    "social_profiles": List<dynamic>.from(socialProfiles.map((x) => x.toJson())),
    "buisness_count": buisnessCount,
    "buisness_profiles": List<dynamic>.from(buisnessProfiles.map((x) => x.toJson())),
  };
}

class Profile {
  Profile({
    this.id,
    this.profileName,
    this.profileType,
    this.profileStatus,
    this.profileImage,
  });

  int id;
  String profileName;
  String profileType;
  String profileStatus;
  String profileImage;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    profileName: json["profile_name"],
    profileType: json["profile_type"],
    profileStatus: json["profile_status"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_name": profileName,
    "profile_type": profileType,
    "profile_status": profileStatus,
    "profile_image": profileImage,
  };
}



/*
/// status_code : 200
/// data : {"social_count":1,"social_profiles":[{"id":6,"profile_name":"k3Pro","profile_type":"social","profile_status":"public"}],"buisness_count":1,"buisness_profiles":[{"id":7,"profile_name":"K2 Business","profile_type":"business","profile_status":"public"}]}

class ProfileCount {
  int _statusCode;
  Data _data;

  int get statusCode => _statusCode;
  Data get data => _data;

  ProfileCount({
      int statusCode, 
      Data data}){
    _statusCode = statusCode;
    _data = data;
}

  ProfileCount.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = _statusCode;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

/// social_count : 1
/// social_profiles : [{"id":6,"profile_name":"k3Pro","profile_type":"social","profile_status":"public"}]
/// buisness_count : 1
/// buisness_profiles : [{"id":7,"profile_name":"K2 Business","profile_type":"business","profile_status":"public"}]

class Data {
  int _socialCount;
  List<Social_profiles> _socialProfiles;
  int _buisnessCount;
  List<Buisness_profiles> _buisnessProfiles;

  int get socialCount => _socialCount;
  List<Social_profiles> get socialProfiles => _socialProfiles;
  int get buisnessCount => _buisnessCount;
  List<Buisness_profiles> get buisnessProfiles => _buisnessProfiles;

  Data({
      int socialCount, 
      List<Social_profiles> socialProfiles, 
      int buisnessCount, 
      List<Buisness_profiles> buisnessProfiles}){
    _socialCount = socialCount;
    _socialProfiles = socialProfiles;
    _buisnessCount = buisnessCount;
    _buisnessProfiles = buisnessProfiles;
}

  Data.fromJson(dynamic json) {
    _socialCount = json["social_count"];
    if (json["social_profiles"] != null) {
      _socialProfiles = [];
      json["social_profiles"].forEach((v) {
        _socialProfiles.add(Social_profiles.fromJson(v));
      });
    }
    _buisnessCount = json["buisness_count"];
    if (json["buisness_profiles"] != null) {
      _buisnessProfiles = [];
      json["buisness_profiles"].forEach((v) {
        _buisnessProfiles.add(Buisness_profiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["social_count"] = _socialCount;
    if (_socialProfiles != null) {
      map["social_profiles"] = _socialProfiles.map((v) => v.toJson()).toList();
    }
    map["buisness_count"] = _buisnessCount;
    if (_buisnessProfiles != null) {
      map["buisness_profiles"] = _buisnessProfiles.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 7
/// profile_name : "K2 Business"
/// profile_type : "business"
/// profile_status : "public"

class Buisness_profiles {
  int _id;
  String _profileName;
  String _profileType;
  String _profileStatus;

  int get id => _id;
  String get profileName => _profileName;
  String get profileType => _profileType;
  String get profileStatus => _profileStatus;

  Buisness_profiles({
      int id, 
      String profileName, 
      String profileType, 
      String profileStatus}){
    _id = id;
    _profileName = profileName;
    _profileType = profileType;
    _profileStatus = profileStatus;
}

  Buisness_profiles.fromJson(dynamic json) {
    _id = json["id"];
    _profileName = json["profile_name"];
    _profileType = json["profile_type"];
    _profileStatus = json["profile_status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["profile_name"] = _profileName;
    map["profile_type"] = _profileType;
    map["profile_status"] = _profileStatus;
    return map;
  }

}

/// id : 6
/// profile_name : "k3Pro"
/// profile_type : "social"
/// profile_status : "public"

class Social_profiles {
  int _id;
  String _profileName;
  String _profileType;
  String _profileStatus;

  int get id => _id;
  String get profileName => _profileName;
  String get profileType => _profileType;
  String get profileStatus => _profileStatus;

  Social_profiles({
      int id, 
      String profileName, 
      String profileType, 
      String profileStatus}){
    _id = id;
    _profileName = profileName;
    _profileType = profileType;
    _profileStatus = profileStatus;
}

  Social_profiles.fromJson(dynamic json) {
    _id = json["id"];
    _profileName = json["profile_name"];
    _profileType = json["profile_type"];
    _profileStatus = json["profile_status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["profile_name"] = _profileName;
    map["profile_type"] = _profileType;
    map["profile_status"] = _profileStatus;
    return map;
  }

}*/

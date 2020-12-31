/// status_code : 200
/// data : [{"profile_id":7,"user_id":5,"profile_name":"first social 7","profile_email":"socialuser4@gmail.com","profile_image":"http://127.0.0.1:8000/storage/default.png","profile_type":"social","profile_status":"public","created_at":"2020-11-18 05:21","profile_is_suspend":"false"},{"profile_id":10,"user_id":8,"profile_name":"first social 10","profile_email":"socialuser7@gmail.com","profile_image":"http://127.0.0.1:8000/storage/profiles/5fb4b02b8d5f6.jpeg","profile_type":"social","profile_status":"public","created_at":"2020-11-18 05:24","profile_is_suspend":"false"},{"profile_id":12,"user_id":10,"profile_name":"first social 12","profile_email":"socialuser9@gmail.com","profile_image":"http://127.0.0.1:8000/storage/profiles/5fb4b6922c62d.jpeg","profile_type":"social","profile_status":"public","created_at":"2020-11-18 05:52","profile_is_suspend":"false"},{"profile_id":13,"user_id":11,"profile_name":"first social","profile_email":"socialuser10@gmail.com","profile_image":"http://127.0.0.1:8000/storage/profiles/5fb4b70773a23.jpeg","profile_type":"social","profile_status":"public","created_at":"2020-11-18 05:54","profile_is_suspend":"false"}]

class SuggestedFriends {
  int _statusCode;
  List<Data> _data;

  int get statusCode => _statusCode;
  List<Data> get data => _data;

  SuggestedFriends({
      int statusCode, 
      List<Data> data}){
    _statusCode = statusCode;
    _data = data;
}

  SuggestedFriends.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = _statusCode;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// profile_id : 7
/// user_id : 5
/// profile_name : "first social 7"
/// profile_email : "socialuser4@gmail.com"
/// profile_image : "http://127.0.0.1:8000/storage/default.png"
/// profile_type : "social"
/// profile_status : "public"
/// created_at : "2020-11-18 05:21"
/// profile_is_suspend : "false"

class Data {
  int _profileId;
  int _userId;
  String _profileName;
  String _profileEmail;
  String _profileImage;
  String _profileType;
  String _profileStatus;
  String _createdAt;
  String _profileIsSuspend;

  int get profileId => _profileId;
  int get userId => _userId;
  String get profileName => _profileName;
  String get profileEmail => _profileEmail;
  String get profileImage => _profileImage;
  String get profileType => _profileType;
  String get profileStatus => _profileStatus;
  String get createdAt => _createdAt;
  String get profileIsSuspend => _profileIsSuspend;

  Data({
      int profileId, 
      int userId, 
      String profileName, 
      String profileEmail, 
      String profileImage, 
      String profileType, 
      String profileStatus, 
      String createdAt, 
      String profileIsSuspend}){
    _profileId = profileId;
    _userId = userId;
    _profileName = profileName;
    _profileEmail = profileEmail;
    _profileImage = profileImage;
    _profileType = profileType;
    _profileStatus = profileStatus;
    _createdAt = createdAt;
    _profileIsSuspend = profileIsSuspend;
}

  Data.fromJson(dynamic json) {
    _profileId = json["profile_id"];
    _userId = json["user_id"];
    _profileName = json["profile_name"];
    _profileEmail = json["profile_email"];
    _profileImage = json["profile_image"];
    _profileType = json["profile_type"];
    _profileStatus = json["profile_status"];
    _createdAt = json["created_at"];
    _profileIsSuspend = json["profile_is_suspend"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["profile_id"] = _profileId;
    map["user_id"] = _userId;
    map["profile_name"] = _profileName;
    map["profile_email"] = _profileEmail;
    map["profile_image"] = _profileImage;
    map["profile_type"] = _profileType;
    map["profile_status"] = _profileStatus;
    map["created_at"] = _createdAt;
    map["profile_is_suspend"] = _profileIsSuspend;
    return map;
  }

}
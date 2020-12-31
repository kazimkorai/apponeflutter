/// status_code : 200
/// data : {"category_id":10,"user_profile_id":"2","user_id":"2","updated_at":"2020-11-19T04:43:10.000000Z","created_at":"2020-11-19T04:43:10.000000Z","id":9}

class EditProfile {
  int _statusCode;
  Data _data;

  int get statusCode => _statusCode;
  Data get data => _data;

  EditProfile({
      int statusCode, 
      Data data}){
    _statusCode = statusCode;
    _data = data;
}

  EditProfile.fromJson(dynamic json) {
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

/// category_id : 10
/// user_profile_id : "2"
/// user_id : "2"
/// updated_at : "2020-11-19T04:43:10.000000Z"
/// created_at : "2020-11-19T04:43:10.000000Z"
/// id : 9

class Data {
  int _categoryId;
  String _userProfileId;
  String _userId;
  String _updatedAt;
  String _createdAt;
  int _id;

  int get categoryId => _categoryId;
  String get userProfileId => _userProfileId;
  String get userId => _userId;
  String get updatedAt => _updatedAt;
  String get createdAt => _createdAt;
  int get id => _id;

  Data({
      int categoryId, 
      String userProfileId, 
      String userId, 
      String updatedAt, 
      String createdAt, 
      int id}){
    _categoryId = categoryId;
    _userProfileId = userProfileId;
    _userId = userId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _categoryId = json["category_id"];
    _userProfileId = json["user_profile_id"];
    _userId = json["user_id"];
    _updatedAt = json["updated_at"];
    _createdAt = json["created_at"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["category_id"] = _categoryId;
    map["user_profile_id"] = _userProfileId;
    map["user_id"] = _userId;
    map["updated_at"] = _updatedAt;
    map["created_at"] = _createdAt;
    map["id"] = _id;
    return map;
  }

}
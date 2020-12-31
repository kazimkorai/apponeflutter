/// status_code : 200
/// data : {"user_id":"2","title":"5th Buisness post","description":"post Disription","user_profile_id":"4","updated_at":"2020-11-18T10:47:28.000000Z","created_at":"2020-11-18T10:47:28.000000Z","id":1}

class CreatePost {
  int _statusCode;
  Data _data;

  int get statusCode => _statusCode;
  Data get data => _data;

  CreatePost({
      int statusCode, 
      Data data}){
    _statusCode = statusCode;
    _data = data;
}

  CreatePost.fromJson(dynamic json) {
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

/// user_id : "2"
/// title : "5th Buisness post"
/// description : "post Disription"
/// user_profile_id : "4"
/// updated_at : "2020-11-18T10:47:28.000000Z"
/// created_at : "2020-11-18T10:47:28.000000Z"
/// id : 1

class Data {
  var _userId;
  String _title;
  String _description;
  var _userProfileId;
  String _updatedAt;
  String _createdAt;
  var _id;

  String get userId => _userId;
  String get title => _title;
  String get description => _description;
  String get userProfileId => _userProfileId;
  String get updatedAt => _updatedAt;
  String get createdAt => _createdAt;
  int get id => _id;

  Data({
      String userId, 
      String title, 
      String description, 
      String userProfileId, 
      String updatedAt, 
      String createdAt, 
      int id}){
    _userId = userId;
    _title = title;
    _description = description;
    _userProfileId = userProfileId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _userId = json["user_id"];
    _title = json["title"];
    _description = json["description"];
    _userProfileId = json["user_profile_id"];
    _updatedAt = json["updated_at"];
    _createdAt = json["created_at"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_id"] = _userId;
    map["title"] = _title;
    map["description"] = _description;
    map["user_profile_id"] = _userProfileId;
    map["updated_at"] = _updatedAt;
    map["created_at"] = _createdAt;
    map["id"] = _id;
    return map;
  }

}
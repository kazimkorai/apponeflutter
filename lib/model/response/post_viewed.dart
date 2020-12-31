/// status_code : 200
/// data : {"user_profile_id":"1","post_id":"1","updated_at":"2020-11-26T09:56:22.000000Z","created_at":"2020-11-26T09:56:22.000000Z","id":1}

class PostViewed {
  int _statusCode;
  Data _data;

  int get statusCode => _statusCode;
  Data get data => _data;

  PostViewed({
      int statusCode, 
      Data data}){
    _statusCode = statusCode;
    _data = data;
}

  PostViewed.fromJson(dynamic json) {
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

/// user_profile_id : "1"
/// post_id : "1"
/// updated_at : "2020-11-26T09:56:22.000000Z"
/// created_at : "2020-11-26T09:56:22.000000Z"
/// id : 1

class Data {
  String _userProfileId;
  String _postId;
  String _updatedAt;
  String _createdAt;
  int _id;

  String get userProfileId => _userProfileId;
  String get postId => _postId;
  String get updatedAt => _updatedAt;
  String get createdAt => _createdAt;
  int get id => _id;

  Data({
      String userProfileId, 
      String postId, 
      String updatedAt, 
      String createdAt, 
      int id}){
    _userProfileId = userProfileId;
    _postId = postId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _userProfileId = json["user_profile_id"];
    _postId = json["post_id"];
    _updatedAt = json["updated_at"];
    _createdAt = json["created_at"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_profile_id"] = _userProfileId;
    map["post_id"] = _postId;
    map["updated_at"] = _updatedAt;
    map["created_at"] = _createdAt;
    map["id"] = _id;
    return map;
  }

}
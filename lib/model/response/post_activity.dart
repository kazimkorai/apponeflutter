/// status_code : 200
/// data : {"id":1,"user_profile_id":2,"post_id":7,"is_like":"false","is_share":"true","is_favourite":"false","deleted_at":null,"created_at":"2020-11-19T05:56:29.000000Z","updated_at":"2020-11-27T11:20:55.000000Z"}

class PostActivity {
  int _statusCode;
  Data _data;

  int get statusCode => _statusCode;
  Data get data => _data;

  PostActivity({
      int statusCode, 
      Data data}){
    _statusCode = statusCode;
    _data = data;
}

  PostActivity.fromJson(dynamic json) {
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

/// id : 1
/// user_profile_id : 2
/// post_id : 7
/// is_like : "false"
/// is_share : "true"
/// is_favourite : "false"
/// deleted_at : null
/// created_at : "2020-11-19T05:56:29.000000Z"
/// updated_at : "2020-11-27T11:20:55.000000Z"

class Data {
  int _id;
  int _userProfileId;
  int _postId;
  String _isLike;
  String _isShare;
  String _isFavourite;
  dynamic _deletedAt;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  int get userProfileId => _userProfileId;
  int get postId => _postId;
  String get isLike => _isLike;
  String get isShare => _isShare;
  String get isFavourite => _isFavourite;
  dynamic get deletedAt => _deletedAt;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Data({
      int id, 
      int userProfileId, 
      int postId, 
      String isLike, 
      String isShare, 
      String isFavourite, 
      dynamic deletedAt, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _userProfileId = userProfileId;
    _postId = postId;
    _isLike = isLike;
    _isShare = isShare;
    _isFavourite = isFavourite;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _userProfileId = int.parse(json["user_profile_id"].toString());
    _postId = json["post_id"];
    _isLike = json["is_like"];
    _isShare = json["is_share"];
    _isFavourite = json["is_favourite"];
    _deletedAt = json["deleted_at"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_profile_id"] = _userProfileId;
    map["post_id"] = _postId;
    map["is_like"] = _isLike;
    map["is_share"] = _isShare;
    map["is_favourite"] = _isFavourite;
    map["deleted_at"] = _deletedAt;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}
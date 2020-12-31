/// status_code : 200
/// data : {"topic_id":5,"user_profile_id":"1","user_id":"2","updated_at":"2020-11-18T11:52:12.000000Z","created_at":"2020-11-18T11:52:12.000000Z","id":5}

class AddTopics {
  int _statusCode;
  Data _data;

  int get statusCode => _statusCode;
  Data get data => _data;

  AddTopics({
      int statusCode, 
      Data data}){
    _statusCode = statusCode;
    _data = data;
}

  AddTopics.fromJson(dynamic json) {
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

/// topic_id : 5
/// user_profile_id : "1"
/// user_id : "2"
/// updated_at : "2020-11-18T11:52:12.000000Z"
/// created_at : "2020-11-18T11:52:12.000000Z"
/// id : 5

class Data {
  int _topicId;
  String _userProfileId;
  String _userId;
  String _updatedAt;
  String _createdAt;
  int _id;

  int get topicId => _topicId;
  String get userProfileId => _userProfileId;
  String get userId => _userId;
  String get updatedAt => _updatedAt;
  String get createdAt => _createdAt;
  int get id => _id;

  Data({
      int topicId, 
      String userProfileId, 
      String userId, 
      String updatedAt, 
      String createdAt, 
      int id}){
    _topicId = topicId;
    _userProfileId = userProfileId;
    _userId = userId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _topicId = json["topic_id"];
    _userProfileId = json["user_profile_id"];
    _userId = json["user_id"];
    _updatedAt = json["updated_at"];
    _createdAt = json["created_at"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["topic_id"] = _topicId;
    map["user_profile_id"] = _userProfileId;
    map["user_id"] = _userId;
    map["updated_at"] = _updatedAt;
    map["created_at"] = _createdAt;
    map["id"] = _id;
    return map;
  }

}
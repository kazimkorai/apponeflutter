/// status_code : 200
/// data : {"follow_by_id":"7","follow_to_id":"4","updated_at":"2020-11-06T09:54:39.000000Z","created_at":"2020-11-06T09:54:39.000000Z","id":1}

class Follow {
  int _statusCode;
  Data _data;

  int get statusCode => _statusCode;
  Data get data => _data;

  Follow({
      int statusCode, 
      Data data}){
    _statusCode = statusCode;
    _data = data;
}

  Follow.fromJson(dynamic json) {
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

/// follow_by_id : "7"
/// follow_to_id : "4"
/// updated_at : "2020-11-06T09:54:39.000000Z"
/// created_at : "2020-11-06T09:54:39.000000Z"
/// id : 1

class Data {
  String _followById;
  String _followToId;
  String _updatedAt;
  String _createdAt;
  int _id;

  String get followById => _followById;
  String get followToId => _followToId;
  String get updatedAt => _updatedAt;
  String get createdAt => _createdAt;
  int get id => _id;

  Data({
      String followById, 
      String followToId, 
      String updatedAt, 
      String createdAt, 
      int id}){
    _followById = followById;
    _followToId = followToId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _followById = json["follow_by_id"];
    _followToId = json["follow_to_id"];
    _updatedAt = json["updated_at"];
    _createdAt = json["created_at"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["follow_by_id"] = _followById;
    map["follow_to_id"] = _followToId;
    map["updated_at"] = _updatedAt;
    map["created_at"] = _createdAt;
    map["id"] = _id;
    return map;
  }

}
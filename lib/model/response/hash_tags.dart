/// status_code : 200
/// data : [{"id":1,"name":"Hard-Work","image":null,"status":"Publish","deleted_at":null,"created_at":"2020-11-18T10:47:28.000000Z","updated_at":"2020-11-18T10:47:28.000000Z"},{"id":2,"name":"Consistancy","image":null,"status":"Publish","deleted_at":null,"created_at":"2020-11-18T10:47:28.000000Z","updated_at":"2020-11-18T10:47:28.000000Z"},{"id":3,"name":"Flying","image":null,"status":"Publish","deleted_at":null,"created_at":"2020-11-19T05:30:36.000000Z","updated_at":"2020-11-19T05:30:36.000000Z"},{"id":4,"name":"Slying","image":null,"status":"Publish","deleted_at":null,"created_at":"2020-11-19T05:31:14.000000Z","updated_at":"2020-11-19T05:31:14.000000Z"},{"id":5,"name":"lying","image":null,"status":"Publish","deleted_at":null,"created_at":"2020-11-20T10:50:48.000000Z","updated_at":"2020-11-20T10:50:48.000000Z"},{"id":6,"name":"Spying","image":null,"status":"Publish","deleted_at":null,"created_at":"2020-11-20T10:51:21.000000Z","updated_at":"2020-11-20T10:51:21.000000Z"},{"id":7,"name":"Zying","image":null,"status":"Publish","deleted_at":null,"created_at":"2020-11-23T06:00:31.000000Z","updated_at":"2020-11-23T06:00:31.000000Z"},{"id":8,"name":"Sying","image":null,"status":"Publish","deleted_at":null,"created_at":"2020-11-23T06:01:34.000000Z","updated_at":"2020-11-23T06:01:34.000000Z"},{"id":9,"name":"Creativity","image":null,"status":"Publish","deleted_at":null,"created_at":"2020-11-24T05:13:10.000000Z","updated_at":"2020-11-24T05:13:10.000000Z"},{"id":10,"name":"Creation","image":null,"status":"Publish","deleted_at":null,"created_at":"2020-11-24T05:13:10.000000Z","updated_at":"2020-11-24T05:13:10.000000Z"}]

class HashTags {
  int _statusCode;
  List<Data> _data;

  int get statusCode => _statusCode;
  List<Data> get data => _data;

  HashTags({
      int statusCode, 
      List<Data> data}){
    _statusCode = statusCode;
    _data = data;
}

  HashTags.fromJson(dynamic json) {
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

/// id : 1
/// name : "Hard-Work"
/// image : null
/// status : "Publish"
/// deleted_at : null
/// created_at : "2020-11-18T10:47:28.000000Z"
/// updated_at : "2020-11-18T10:47:28.000000Z"

class Data {
  int _id;
  String _name;
  dynamic _image;
  String _status;
  dynamic _deletedAt;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get name => _name;
  dynamic get image => _image;
  String get status => _status;
  dynamic get deletedAt => _deletedAt;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Data({
      int id, 
      String name, 
      dynamic image, 
      String status, 
      dynamic deletedAt, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _name = name;
    _image = image;
    _status = status;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _image = json["image"];
    _status = json["status"];
    _deletedAt = json["deleted_at"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["image"] = _image;
    map["status"] = _status;
    map["deleted_at"] = _deletedAt;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}
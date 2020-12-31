/// status_code : 200
/// data : [{"id":1,"name":"Gaming","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T05:58:46.000000Z","updated_at":"2020-11-02T05:58:46.000000Z"},{"id":2,"name":"Showbiz","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T05:58:46.000000Z","updated_at":"2020-11-02T05:58:46.000000Z"},{"id":3,"name":"Sports","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T05:58:46.000000Z","updated_at":"2020-11-02T05:58:46.000000Z"},{"id":4,"name":"Gaming","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T06:34:55.000000Z","updated_at":"2020-11-02T06:34:55.000000Z"},{"id":5,"name":"Showbiz","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T06:34:55.000000Z","updated_at":"2020-11-02T06:34:55.000000Z"},{"id":6,"name":"Sports","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T06:34:55.000000Z","updated_at":"2020-11-02T06:34:55.000000Z"},{"id":7,"name":"Gaming","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:13:57.000000Z","updated_at":"2020-11-02T07:13:57.000000Z"},{"id":8,"name":"Showbiz","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:13:57.000000Z","updated_at":"2020-11-02T07:13:57.000000Z"},{"id":9,"name":"Sports","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:13:57.000000Z","updated_at":"2020-11-02T07:13:57.000000Z"},{"id":10,"name":"Gaming","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:16:20.000000Z","updated_at":"2020-11-02T07:16:20.000000Z"},{"id":11,"name":"Showbiz","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:16:20.000000Z","updated_at":"2020-11-02T07:16:20.000000Z"},{"id":12,"name":"Sports","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:16:20.000000Z","updated_at":"2020-11-02T07:16:20.000000Z"},{"id":13,"name":"Gaming","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:17:45.000000Z","updated_at":"2020-11-02T07:17:45.000000Z"},{"id":14,"name":"Showbiz","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:17:45.000000Z","updated_at":"2020-11-02T07:17:45.000000Z"},{"id":15,"name":"Sports","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:17:45.000000Z","updated_at":"2020-11-02T07:17:45.000000Z"},{"id":16,"name":"Gaming","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:20:30.000000Z","updated_at":"2020-11-02T07:20:30.000000Z"},{"id":17,"name":"Showbiz","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:20:30.000000Z","updated_at":"2020-11-02T07:20:30.000000Z"},{"id":18,"name":"Sports","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:20:30.000000Z","updated_at":"2020-11-02T07:20:30.000000Z"},{"id":19,"name":"Gaming","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:24:49.000000Z","updated_at":"2020-11-02T07:24:49.000000Z"},{"id":20,"name":"Showbiz","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:24:49.000000Z","updated_at":"2020-11-02T07:24:49.000000Z"},{"id":21,"name":"Sports","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:24:49.000000Z","updated_at":"2020-11-02T07:24:49.000000Z"},{"id":22,"name":"Gaming","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:26:29.000000Z","updated_at":"2020-11-02T07:26:29.000000Z"},{"id":23,"name":"Showbiz","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:26:29.000000Z","updated_at":"2020-11-02T07:26:29.000000Z"},{"id":24,"name":"Sports","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T07:26:29.000000Z","updated_at":"2020-11-02T07:26:29.000000Z"},{"id":25,"name":"Pubg","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T09:34:59.000000Z","updated_at":"2020-11-02T09:34:59.000000Z"},{"id":26,"name":"IT","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T10:36:33.000000Z","updated_at":"2020-11-02T10:36:33.000000Z"},{"id":27,"name":"IT","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-02T10:45:44.000000Z","updated_at":"2020-11-02T10:45:44.000000Z"},{"id":28,"name":"IT","image":null,"status":"publish","deleted_at":null,"created_at":"2020-11-03T07:38:43.000000Z","updated_at":"2020-11-03T07:38:43.000000Z"}]

class AllCategories {
  int _statusCode;
  List<Data> _data;

  int get statusCode => _statusCode;
  List<Data> get data => _data;

  AllCategories({
      int statusCode, 
      List<Data> data}){
    _statusCode = statusCode;
    _data = data;
}

  AllCategories.fromJson(dynamic json) {
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
/// name : "Gaming"
/// image : null
/// status : "publish"
/// deleted_at : null
/// created_at : "2020-11-02T05:58:46.000000Z"
/// updated_at : "2020-11-02T05:58:46.000000Z"

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
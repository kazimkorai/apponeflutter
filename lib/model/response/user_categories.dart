/// status_code : 200
/// data : [{"id":1,"name":"Gaming"},{"id":2,"name":"IT"}]

class UserCategories {
  int _statusCode;
  List<Data> _data;

  int get statusCode => _statusCode;
  List<Data> get data => _data;

  UserCategories({
      int statusCode, 
      List<Data> data}){
    _statusCode = statusCode;
    _data = data;
}

  UserCategories.fromJson(dynamic json) {
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

class Data {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Data({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}
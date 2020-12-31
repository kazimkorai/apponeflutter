/// status_code : 200
/// data : 1

class Unfollow {
  int _statusCode;
  int _data;

  int get statusCode => _statusCode;
  int get data => _data;

  Unfollow({
      int statusCode, 
      int data}){
    _statusCode = statusCode;
    _data = data;
}

  Unfollow.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _data = json["data"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = _statusCode;
    map["data"] = _data;
    return map;
  }
}
/// status_code : 200
/// data : {"followers":2,"interest":"Hardware,IT","id":4,"name":"Alo 3","email":"secondbusiness@gmail.com","profile_status":"public","profile_type":"social","followeing":1,"posts":1,"is_following":"false"}

class ProfileInfo {
  int _statusCode;
  Data _data;

  int get statusCode => _statusCode;
  Data get data => _data;

  ProfileInfo({
      int statusCode, 
      Data data}){
    _statusCode = statusCode;
    _data = data;
}

  ProfileInfo.fromJson(dynamic json) {
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

/// followers : 2
/// interest : "Hardware,IT"
/// id : 4
/// name : "Alo 3"
/// email : "secondbusiness@gmail.com"
/// profile_status : "public"
/// profile_type : "social"
/// followeing : 1
/// posts : 1
/// is_following : "false"

class Data {
  int _followers;
  String _interest;
  int _id;
  String _name;
  String _email;
  String _profileStatus;
  String _profileType;
  int _followeing;
  int _posts;
  String _isFollowing;

  int get followers => _followers;
  String get interest => _interest;
  int get id => _id;
  String get name => _name;
  String get email => _email;
  String get profileStatus => _profileStatus;
  String get profileType => _profileType;
  int get followeing => _followeing;
  int get posts => _posts;
  String get isFollowing => _isFollowing;

  Data({
      int followers, 
      String interest, 
      int id, 
      String name, 
      String email, 
      String profileStatus, 
      String profileType, 
      int followeing, 
      int posts, 
      String isFollowing}){
    _followers = followers;
    _interest = interest;
    _id = id;
    _name = name;
    _email = email;
    _profileStatus = profileStatus;
    _profileType = profileType;
    _followeing = followeing;
    _posts = posts;
    _isFollowing = isFollowing;
}

  Data.fromJson(dynamic json) {
    _followers = json["followers"];
    _interest = json["interest"];
    _id = json["id"];
    _name = json["name"];
    _email = json["email"];
    _profileStatus = json["profile_status"];
    _profileType = json["profile_type"];
    _followeing = json["followeing"];
    _posts = json["posts"];
    _isFollowing = json["is_following"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["followers"] = _followers;
    map["interest"] = _interest;
    map["id"] = _id;
    map["name"] = _name;
    map["email"] = _email;
    map["profile_status"] = _profileStatus;
    map["profile_type"] = _profileType;
    map["followeing"] = _followeing;
    map["posts"] = _posts;
    map["is_following"] = _isFollowing;
    return map;
  }

}
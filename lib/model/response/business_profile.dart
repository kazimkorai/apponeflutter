/// status_code : 200
/// data : {"user_id":"15","country_id":"1","city_id":"1","profile_name":"second business","profile_email":"secondbusiness@gmail.com","profile_image":"profiles/default.png","profile_phone":"12345678","profile_address":"second test","profile_website":"second test","profile_about":"test second profile about","profile_banner":"default.png","profile_type":"business","profile_status":"public","updated_at":"2020-11-03T07:38:43.000000Z","created_at":"2020-11-03T07:38:43.000000Z","id":12}

class BusinessProfile {
  int _statusCode;
  Data _data;

  int get statusCode => _statusCode;
  Data get data => _data;

  BusinessProfile({
      int statusCode, 
      Data data}){
    _statusCode = statusCode;
    _data = data;
}

  BusinessProfile.fromJson(dynamic json) {
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

/// user_id : "15"
/// country_id : "1"
/// city_id : "1"
/// profile_name : "second business"
/// profile_email : "secondbusiness@gmail.com"
/// profile_image : "profiles/default.png"
/// profile_phone : "12345678"
/// profile_address : "second test"
/// profile_website : "second test"
/// profile_about : "test second profile about"
/// profile_banner : "default.png"
/// profile_type : "business"
/// profile_status : "public"
/// updated_at : "2020-11-03T07:38:43.000000Z"
/// created_at : "2020-11-03T07:38:43.000000Z"
/// id : 12

class Data {
  String _userId;
  String _countryId;
  String _cityId;
  String _profileName;
  String _profileEmail;
  String _profileImage;
  String _profilePhone;
  String _profileAddress;
  String _profileWebsite;
  String _profileAbout;
  String _profileBanner;
  String _profileType;
  String _profileStatus;
  String _updatedAt;
  String _createdAt;
  int _id;

  String get userId => _userId;
  String get countryId => _countryId;
  String get cityId => _cityId;
  String get profileName => _profileName;
  String get profileEmail => _profileEmail;
  String get profileImage => _profileImage;
  String get profilePhone => _profilePhone;
  String get profileAddress => _profileAddress;
  String get profileWebsite => _profileWebsite;
  String get profileAbout => _profileAbout;
  String get profileBanner => _profileBanner;
  String get profileType => _profileType;
  String get profileStatus => _profileStatus;
  String get updatedAt => _updatedAt;
  String get createdAt => _createdAt;
  int get id => _id;

  Data({
      String userId, 
      String countryId, 
      String cityId, 
      String profileName, 
      String profileEmail, 
      String profileImage, 
      String profilePhone, 
      String profileAddress, 
      String profileWebsite, 
      String profileAbout, 
      String profileBanner, 
      String profileType, 
      String profileStatus, 
      String updatedAt, 
      String createdAt, 
      int id}){
    _userId = userId;
    _countryId = countryId;
    _cityId = cityId;
    _profileName = profileName;
    _profileEmail = profileEmail;
    _profileImage = profileImage;
    _profilePhone = profilePhone;
    _profileAddress = profileAddress;
    _profileWebsite = profileWebsite;
    _profileAbout = profileAbout;
    _profileBanner = profileBanner;
    _profileType = profileType;
    _profileStatus = profileStatus;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _userId = json["user_id"];
    _countryId = json["country_id"];
    _cityId = json["city_id"];
    _profileName = json["profile_name"];
    _profileEmail = json["profile_email"];
    _profileImage = json["profile_image"];
    _profilePhone = json["profile_phone"];
    _profileAddress = json["profile_address"];
    _profileWebsite = json["profile_website"];
    _profileAbout = json["profile_about"];
    _profileBanner = json["profile_banner"];
    _profileType = json["profile_type"];
    _profileStatus = json["profile_status"];
    _updatedAt = json["updated_at"];
    _createdAt = json["created_at"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_id"] = _userId;
    map["country_id"] = _countryId;
    map["city_id"] = _cityId;
    map["profile_name"] = _profileName;
    map["profile_email"] = _profileEmail;
    map["profile_image"] = _profileImage;
    map["profile_phone"] = _profilePhone;
    map["profile_address"] = _profileAddress;
    map["profile_website"] = _profileWebsite;
    map["profile_about"] = _profileAbout;
    map["profile_banner"] = _profileBanner;
    map["profile_type"] = _profileType;
    map["profile_status"] = _profileStatus;
    map["updated_at"] = _updatedAt;
    map["created_at"] = _createdAt;
    map["id"] = _id;
    return map;
  }

}
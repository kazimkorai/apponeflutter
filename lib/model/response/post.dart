/// status_code : 200
/// data : [{"post_id":7,"title":2,"description":"post Disription","is_featured":"false","created_at":"5 days ago","post_comments_count":1,"is_share_count":1,"is_like_count":1,"is_self_like":"true","images":[{"image_id":7,"image":"https://breakhot.com/apponecms/public/storage/default.png","video":"https://breakhot.com/apponecms/public/storage/default.png"}],"hash_tag":[{"hash_tag_id":4,"name":"Slying","status":"Publish"}],"category":[{"category_id":14,"name":"Slying","status":"publish"}],"user_profile":{"profile_id":2,"profile_name":"k1@gmail.com","profile_image":"https://breakhot.com/apponecms/public/storage/default.png"}},{"post_id":9,"title":3,"description":"post Disription","is_featured":"false","created_at":"4 days ago","post_comments_count":0,"is_share_count":0,"is_like_count":0,"is_self_like":"false","images":[{"image_id":9,"image":"https://breakhot.com/apponecms/public/storage/default.png","video":"https://breakhot.com/apponecms/public/storage/default.png"}],"hash_tag":[{"hash_tag_id":5,"name":"lying","status":"Publish"}],"category":[{"category_id":17,"name":"lying","status":"publish"}],"user_profile":{"profile_id":2,"profile_name":"k1@gmail.com","profile_image":"https://breakhot.com/apponecms/public/storage/default.png"}},{"post_id":10,"title":2,"description":"post Disription","is_featured":"false","created_at":"4 days ago","post_comments_count":0,"is_share_count":0,"is_like_count":0,"is_self_like":"false","images":[{"image_id":10,"image":"https://breakhot.com/apponecms/public/storage/default.png","video":"https://breakhot.com/apponecms/public/storage/default.png"}],"hash_tag":[{"hash_tag_id":6,"name":"Spying","status":"Publish"}],"category":[{"category_id":18,"name":"Spying","status":"publish"}],"user_profile":{"profile_id":2,"profile_name":"k1@gmail.com","profile_image":"https://breakhot.com/apponecms/public/storage/default.png"}},{"post_id":15,"title":2,"description":"post Disription","is_featured":"false","created_at":"1 day ago","post_comments_count":0,"is_share_count":0,"is_like_count":1,"is_self_like":"true","images":[{"image_id":15,"image":"https://breakhot.com/apponecms/public/storage/default.png","video":"https://breakhot.com/apponecms/public/storage/default.png"}],"hash_tag":[{"hash_tag_id":1,"name":"Hard-Work","status":"Publish"},{"hash_tag_id":2,"name":"Consistancy","status":"Publish"}],"category":[{"category_id":1,"name":"Hardware","status":"publish"},{"category_id":2,"name":"Buisness","status":"publish"}],"user_profile":{"profile_id":2,"profile_name":"k1@gmail.com","profile_image":"https://breakhot.com/apponecms/public/storage/default.png"}},{"post_id":16,"title":2,"description":"Its the latest Dawn Post you guys need to see.","is_featured":"false","created_at":"1 day ago","post_comments_count":0,"is_share_count":0,"is_like_count":0,"is_self_like":"false","images":[{"image_id":16,"image":"https://breakhot.com/apponecms/public/storage/default.png","video":"https://breakhot.com/apponecms/public/storage/default.png"}],"hash_tag":[{"hash_tag_id":7,"name":"Zying","status":"Publish"}],"category":[{"category_id":10,"name":"Running","status":"publish"}],"user_profile":{"profile_id":2,"profile_name":"k1@gmail.com","profile_image":"https://breakhot.com/apponecms/public/storage/default.png"}},{"post_id":17,"title":2,"description":"Its the latest Dawn Post you guys need to see.","is_featured":"false","created_at":"1 day ago","post_comments_count":0,"is_share_count":0,"is_like_count":0,"is_self_like":"false","images":[{"image_id":17,"image":"https://breakhot.com/apponecms/public/storage/default.png","video":"https://breakhot.com/apponecms/public/storage/default.png"}],"hash_tag":[{"hash_tag_id":8,"name":"Sying","status":"Publish"}],"category":[{"category_id":10,"name":"Running","status":"publish"}],"user_profile":{"profile_id":2,"profile_name":"k1@gmail.com","profile_image":"https://breakhot.com/apponecms/public/storage/default.png"}}]
/// next : ""
/// previous : ""
/// per_page : 10
/// current_page : 1
/// total : 6

class Post {
  int _statusCode;
  List<Data> _data;
  String _next;
  String _previous;
  int _perPage;
  int _currentPage;
  int _total;

  int get statusCode => _statusCode;
  List<Data> get data => _data;
  String get next => _next;
  String get previous => _previous;
  int get perPage => _perPage;
  int get currentPage => _currentPage;
  int get total => _total;

  Post({
      int statusCode, 
      List<Data> data, 
      String next, 
      String previous, 
      int perPage, 
      int currentPage, 
      int total}){
    _statusCode = statusCode;
    _data = data;
    _next = next;
    _previous = previous;
    _perPage = perPage;
    _currentPage = currentPage;
    _total = total;
}

  Post.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
    _next = json["next"];
    _previous = json["previous"];
    _perPage = json["per_page"];
    _currentPage = json["current_page"];
    _total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = _statusCode;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    map["next"] = _next;
    map["previous"] = _previous;
    map["per_page"] = _perPage;
    map["current_page"] = _currentPage;
    map["total"] = _total;
    return map;
  }

}

/// post_id : 7
/// title : 2
/// description : "post Disription"
/// is_featured : "false"
/// created_at : "5 days ago"
/// post_comments_count : 1
/// is_share_count : 1
/// is_like_count : 1
/// is_self_like : "true"
/// images : [{"image_id":7,"image":"https://breakhot.com/apponecms/public/storage/default.png","video":"https://breakhot.com/apponecms/public/storage/default.png"}]
/// hash_tag : [{"hash_tag_id":4,"name":"Slying","status":"Publish"}]
/// category : [{"category_id":14,"name":"Slying","status":"publish"}]
/// user_profile : {"profile_id":2,"profile_name":"k1@gmail.com","profile_image":"https://breakhot.com/apponecms/public/storage/default.png"}

class Data {
  int _postId;
  int _title;
  String _description;
  String _isFeatured;
  String _createdAt;
  int _postCommentsCount;
  int _isShareCount;
  int _isLikeCount;
  String _isSelfLike;
  List<Images> _images;
  List<Hash_tag> _hashTag;
  List<Category> _category;
  User_profile _userProfile;

  int get postId => _postId;
  int get title => _title;
  String get description => _description;
  String get isFeatured => _isFeatured;
  String get createdAt => _createdAt;
  int get postCommentsCount => _postCommentsCount;
  int get isShareCount => _isShareCount;
  int get isLikeCount => _isLikeCount;
  String get isSelfLike => _isSelfLike;
  List<Images> get images => _images;
  List<Hash_tag> get hashTag => _hashTag;
  List<Category> get category => _category;
  User_profile get userProfile => _userProfile;

  Data({
      int postId, 
      int title, 
      String description, 
      String isFeatured, 
      String createdAt, 
      int postCommentsCount, 
      int isShareCount, 
      int isLikeCount, 
      String isSelfLike, 
      List<Images> images, 
      List<Hash_tag> hashTag, 
      List<Category> category, 
      User_profile userProfile}){
    _postId = postId;
    _title = title;
    _description = description;
    _isFeatured = isFeatured;
    _createdAt = createdAt;
    _postCommentsCount = postCommentsCount;
    _isShareCount = isShareCount;
    _isLikeCount = isLikeCount;
    _isSelfLike = isSelfLike;
    _images = images;
    _hashTag = hashTag;
    _category = category;
    _userProfile = userProfile;
}

  Data.fromJson(dynamic json) {
    _postId = json["post_id"];
    _title = json["title"];
    _description = json["description"];
    _isFeatured = json["is_featured"];
    _createdAt = json["created_at"];
    _postCommentsCount = json["post_comments_count"];
    _isShareCount = json["is_share_count"];
    _isLikeCount = json["is_like_count"];
    _isSelfLike = json["is_self_like"];
    if (json["images"] != null) {
      _images = [];
      json["images"].forEach((v) {
        _images.add(Images.fromJson(v));
      });
    }
    if (json["hash_tag"] != null) {
      _hashTag = [];
      json["hash_tag"].forEach((v) {
        _hashTag.add(Hash_tag.fromJson(v));
      });
    }
    if (json["category"] != null) {
      _category = [];
      json["category"].forEach((v) {
        _category.add(Category.fromJson(v));
      });
    }
    _userProfile = json["user_profile"] != null ? User_profile.fromJson(json["user_profile"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["post_id"] = _postId;
    map["title"] = _title;
    map["description"] = _description;
    map["is_featured"] = _isFeatured;
    map["created_at"] = _createdAt;
    map["post_comments_count"] = _postCommentsCount;
    map["is_share_count"] = _isShareCount;
    map["is_like_count"] = _isLikeCount;
    map["is_self_like"] = _isSelfLike;
    if (_images != null) {
      map["images"] = _images.map((v) => v.toJson()).toList();
    }
    if (_hashTag != null) {
      map["hash_tag"] = _hashTag.map((v) => v.toJson()).toList();
    }
    if (_category != null) {
      map["category"] = _category.map((v) => v.toJson()).toList();
    }
    if (_userProfile != null) {
      map["user_profile"] = _userProfile.toJson();
    }
    return map;
  }

}

/// profile_id : 2
/// profile_name : "k1@gmail.com"
/// profile_image : "https://breakhot.com/apponecms/public/storage/default.png"

class User_profile {
  int _profileId;
  String _profileName;
  String _profileImage;

  int get profileId => _profileId;
  String get profileName => _profileName;
  String get profileImage => _profileImage;

  User_profile({
      int profileId, 
      String profileName, 
      String profileImage}){
    _profileId = profileId;
    _profileName = profileName;
    _profileImage = profileImage;
}

  User_profile.fromJson(dynamic json) {
    _profileId = json["profile_id"];
    _profileName = json["profile_name"];
    _profileImage = json["profile_image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["profile_id"] = _profileId;
    map["profile_name"] = _profileName;
    map["profile_image"] = _profileImage;
    return map;
  }

}

/// category_id : 14
/// name : "Slying"
/// status : "publish"

class Category {
  int _categoryId;
  String _name;
  String _status;

  int get categoryId => _categoryId;
  String get name => _name;
  String get status => _status;

  Category({
      int categoryId, 
      String name, 
      String status}){
    _categoryId = categoryId;
    _name = name;
    _status = status;
}

  Category.fromJson(dynamic json) {
    _categoryId = json["category_id"];
    _name = json["name"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["category_id"] = _categoryId;
    map["name"] = _name;
    map["status"] = _status;
    return map;
  }

}

/// hash_tag_id : 4
/// name : "Slying"
/// status : "Publish"

class Hash_tag {
  int _hashTagId;
  String _name;
  String _status;

  int get hashTagId => _hashTagId;
  String get name => _name;
  String get status => _status;

  Hash_tag({
      int hashTagId, 
      String name, 
      String status}){
    _hashTagId = hashTagId;
    _name = name;
    _status = status;
}

  Hash_tag.fromJson(dynamic json) {
    _hashTagId = json["hash_tag_id"];
    _name = json["name"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["hash_tag_id"] = _hashTagId;
    map["name"] = _name;
    map["status"] = _status;
    return map;
  }

}

/// image_id : 7
/// image : "https://breakhot.com/apponecms/public/storage/default.png"
/// video : "https://breakhot.com/apponecms/public/storage/default.png"

class Images {
  int _imageId;
  String _image;
  String _video;

  int get imageId => _imageId;
  String get image => _image;
  String get video => _video;

  Images({
      int imageId, 
      String image, 
      String video}){
    _imageId = imageId;
    _image = image;
    _video = video;
}

  Images.fromJson(dynamic json) {
    _imageId = json["image_id"];
    _image = json["image"];
    _video = json["video"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["image_id"] = _imageId;
    map["image"] = _image;
    map["video"] = _video;
    return map;
  }

}
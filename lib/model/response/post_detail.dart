/// status_code : 200
/// data : {"post_id":7,"title":2,"description":"post Disription","is_featured":"false","created_at":"1 week ago","post_comments_count":5,"is_share_count":0,"is_like_count":0,"is_self_like":"false","profile_id":2,"profile_name":"k1@gmail.com","profile_image":"https://breakhot.com/apponecms/public/storage/default.png","images":[{"image_id":7,"image":"https://breakhot.com/apponecms/public/storage/default.png","video":"https://breakhot.com/apponecms/public/storage/default.png"}],"hash_tag":[{"hash_tag_id":4,"name":"Slying","status":"Publish"}],"category":[{"hash_tag_id":14,"name":"Slying","status":"publish"}],"comments":[{"comment_id":1,"comment":"some text about post","status":"true","comment_created_at":"2020-11-19T05:32:54.000000Z","comment_likes_count":0,"self_comment_like":"false","comment_by_profile_id":2,"comment_by_profile_name":"k1@gmail.com","comment_by_profile_image":"https://breakhot.com/apponecms/public/storage/profiles/5fb4fab1e8ad2.png"},{"comment_id":3,"comment":"I love it","status":"true","comment_created_at":"2020-11-26T07:10:18.000000Z","comment_likes_count":0,"self_comment_like":"false","comment_by_profile_id":2,"comment_by_profile_name":"k1@gmail.com","comment_by_profile_image":"https://breakhot.com/apponecms/public/storage/profiles/5fb4fab1e8ad2.png"},{"comment_id":4,"comment":"some text about post","status":"true","comment_created_at":"2020-11-26T07:11:07.000000Z","comment_likes_count":0,"self_comment_like":"false","comment_by_profile_id":2,"comment_by_profile_name":"k1@gmail.com","comment_by_profile_image":"https://breakhot.com/apponecms/public/storage/profiles/5fb4fab1e8ad2.png"},{"comment_id":5,"comment":"I love it","status":"true","comment_created_at":"2020-11-26T07:13:48.000000Z","comment_likes_count":0,"self_comment_like":"false","comment_by_profile_id":2,"comment_by_profile_name":"k1@gmail.com","comment_by_profile_image":"https://breakhot.com/apponecms/public/storage/profiles/5fb4fab1e8ad2.png"},{"comment_id":6,"comment":"Yeahs Thats True","status":"true","comment_created_at":"2020-11-26T07:16:11.000000Z","comment_likes_count":0,"self_comment_like":"false","comment_by_profile_id":2,"comment_by_profile_name":"k1@gmail.com","comment_by_profile_image":"https://breakhot.com/apponecms/public/storage/profiles/5fb4fab1e8ad2.png"}]}

class PostDetail {
  int _statusCode;
  Data _data;

  int get statusCode => _statusCode;
  Data get data => _data;

  PostDetail({
      int statusCode, 
      Data data}){
    _statusCode = statusCode;
    _data = data;
}

  PostDetail.fromJson(dynamic json) {
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

/// post_id : 7
/// title : 2
/// description : "post Disription"
/// is_featured : "false"
/// created_at : "1 week ago"
/// post_comments_count : 5
/// is_share_count : 0
/// is_like_count : 0
/// is_self_like : "false"
/// profile_id : 2
/// profile_name : "k1@gmail.com"
/// profile_image : "https://breakhot.com/apponecms/public/storage/default.png"
/// images : [{"image_id":7,"image":"https://breakhot.com/apponecms/public/storage/default.png","video":"https://breakhot.com/apponecms/public/storage/default.png"}]
/// hash_tag : [{"hash_tag_id":4,"name":"Slying","status":"Publish"}]
/// category : [{"hash_tag_id":14,"name":"Slying","status":"publish"}]
/// comments : [{"comment_id":1,"comment":"some text about post","status":"true","comment_created_at":"2020-11-19T05:32:54.000000Z","comment_likes_count":0,"self_comment_like":"false","comment_by_profile_id":2,"comment_by_profile_name":"k1@gmail.com","comment_by_profile_image":"https://breakhot.com/apponecms/public/storage/profiles/5fb4fab1e8ad2.png"},{"comment_id":3,"comment":"I love it","status":"true","comment_created_at":"2020-11-26T07:10:18.000000Z","comment_likes_count":0,"self_comment_like":"false","comment_by_profile_id":2,"comment_by_profile_name":"k1@gmail.com","comment_by_profile_image":"https://breakhot.com/apponecms/public/storage/profiles/5fb4fab1e8ad2.png"},{"comment_id":4,"comment":"some text about post","status":"true","comment_created_at":"2020-11-26T07:11:07.000000Z","comment_likes_count":0,"self_comment_like":"false","comment_by_profile_id":2,"comment_by_profile_name":"k1@gmail.com","comment_by_profile_image":"https://breakhot.com/apponecms/public/storage/profiles/5fb4fab1e8ad2.png"},{"comment_id":5,"comment":"I love it","status":"true","comment_created_at":"2020-11-26T07:13:48.000000Z","comment_likes_count":0,"self_comment_like":"false","comment_by_profile_id":2,"comment_by_profile_name":"k1@gmail.com","comment_by_profile_image":"https://breakhot.com/apponecms/public/storage/profiles/5fb4fab1e8ad2.png"},{"comment_id":6,"comment":"Yeahs Thats True","status":"true","comment_created_at":"2020-11-26T07:16:11.000000Z","comment_likes_count":0,"self_comment_like":"false","comment_by_profile_id":2,"comment_by_profile_name":"k1@gmail.com","comment_by_profile_image":"https://breakhot.com/apponecms/public/storage/profiles/5fb4fab1e8ad2.png"}]

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
  int _profileId;
  String _profileName;
  String _profileImage;
  List<Images> _images;
  List<Hash_tag> _hashTag;
  List<Category> _category;
  List<Comments> _comments;

  int get postId => _postId;
  int get title => _title;
  String get description => _description;
  String get isFeatured => _isFeatured;
  String get createdAt => _createdAt;
  int get postCommentsCount => _postCommentsCount;
  int get isShareCount => _isShareCount;
  int get isLikeCount => _isLikeCount;
  String get isSelfLike => _isSelfLike;
  int get profileId => _profileId;
  String get profileName => _profileName;
  String get profileImage => _profileImage;
  List<Images> get images => _images;
  List<Hash_tag> get hashTag => _hashTag;
  List<Category> get category => _category;
  List<Comments> get comments => _comments;

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
      int profileId, 
      String profileName, 
      String profileImage, 
      List<Images> images, 
      List<Hash_tag> hashTag, 
      List<Category> category, 
      List<Comments> comments}){
    _postId = postId;
    _title = title;
    _description = description;
    _isFeatured = isFeatured;
    _createdAt = createdAt;
    _postCommentsCount = postCommentsCount;
    _isShareCount = isShareCount;
    _isLikeCount = isLikeCount;
    _isSelfLike = isSelfLike;
    _profileId = profileId;
    _profileName = profileName;
    _profileImage = profileImage;
    _images = images;
    _hashTag = hashTag;
    _category = category;
    _comments = comments;
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
    _profileId = json["profile_id"];
    _profileName = json["profile_name"];
    _profileImage = json["profile_image"];
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
    if (json["comments"] != null) {
      _comments = [];
      json["comments"].forEach((v) {
        _comments.add(Comments.fromJson(v));
      });
    }
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
    map["profile_id"] = _profileId;
    map["profile_name"] = _profileName;
    map["profile_image"] = _profileImage;
    if (_images != null) {
      map["images"] = _images.map((v) => v.toJson()).toList();
    }
    if (_hashTag != null) {
      map["hash_tag"] = _hashTag.map((v) => v.toJson()).toList();
    }
    if (_category != null) {
      map["category"] = _category.map((v) => v.toJson()).toList();
    }
    if (_comments != null) {
      map["comments"] = _comments.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// comment_id : 1
/// comment : "some text about post"
/// status : "true"
/// comment_created_at : "2020-11-19T05:32:54.000000Z"
/// comment_likes_count : 0
/// self_comment_like : "false"
/// comment_by_profile_id : 2
/// comment_by_profile_name : "k1@gmail.com"
/// comment_by_profile_image : "https://breakhot.com/apponecms/public/storage/profiles/5fb4fab1e8ad2.png"

class Comments {
  int _commentId;
  String _comment;
  String _status;
  String _commentCreatedAt;
  int _commentLikesCount;
  String _selfCommentLike;
  int _commentByProfileId;
  String _commentByProfileName;
  String _commentByProfileImage;

  int get commentId => _commentId;
  String get comment => _comment;
  String get status => _status;
  String get commentCreatedAt => _commentCreatedAt;
  int get commentLikesCount => _commentLikesCount;
  String get selfCommentLike => _selfCommentLike;
  int get commentByProfileId => _commentByProfileId;
  String get commentByProfileName => _commentByProfileName;
  String get commentByProfileImage => _commentByProfileImage;

  Comments({
      int commentId, 
      String comment, 
      String status, 
      String commentCreatedAt, 
      int commentLikesCount, 
      String selfCommentLike, 
      int commentByProfileId, 
      String commentByProfileName, 
      String commentByProfileImage}){
    _commentId = commentId;
    _comment = comment;
    _status = status;
    _commentCreatedAt = commentCreatedAt;
    _commentLikesCount = commentLikesCount;
    _selfCommentLike = selfCommentLike;
    _commentByProfileId = commentByProfileId;
    _commentByProfileName = commentByProfileName;
    _commentByProfileImage = commentByProfileImage;
}

  Comments.fromJson(dynamic json) {
    _commentId = json["comment_id"];
    _comment = json["comment"];
    _status = json["status"];
    _commentCreatedAt = json["comment_created_at"];
    _commentLikesCount = json["comment_likes_count"];
    _selfCommentLike = json["self_comment_like"];
    _commentByProfileId = json["comment_by_profile_id"];
    _commentByProfileName = json["comment_by_profile_name"];
    _commentByProfileImage = json["comment_by_profile_image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["comment_id"] = _commentId;
    map["comment"] = _comment;
    map["status"] = _status;
    map["comment_created_at"] = _commentCreatedAt;
    map["comment_likes_count"] = _commentLikesCount;
    map["self_comment_like"] = _selfCommentLike;
    map["comment_by_profile_id"] = _commentByProfileId;
    map["comment_by_profile_name"] = _commentByProfileName;
    map["comment_by_profile_image"] = _commentByProfileImage;
    return map;
  }

}

/// hash_tag_id : 14
/// name : "Slying"
/// status : "publish"

class Category {
  int _hashTagId;
  String _name;
  String _status;

  int get hashTagId => _hashTagId;
  String get name => _name;
  String get status => _status;

  Category({
      int hashTagId, 
      String name, 
      String status}){
    _hashTagId = hashTagId;
    _name = name;
    _status = status;
}

  Category.fromJson(dynamic json) {
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
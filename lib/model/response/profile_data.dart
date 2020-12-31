/// status_code : 200
/// data : [{"id":7,"title":"6th Buisness post","description":"post Disription","is_featured":"false","images":[{"image_id":7,"image":"https://breakhot.com/apponecms/storage/posts/5fb60322afd68.png","video":"https://breakhot.com/apponecms/storage/default.png","created_at":"1 hour ago"}],"postTopics":[{"topic_id":8,"post_id":7}]}]
/// next : ""
/// previous : ""
/// per_page : 10
/// current_page : 1
/// total : 1

class ProfileData {
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

  ProfileData({
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

  ProfileData.fromJson(dynamic json) {
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

/// id : 7
/// title : "6th Buisness post"
/// description : "post Disription"
/// is_featured : "false"
/// images : [{"image_id":7,"image":"https://breakhot.com/apponecms/storage/posts/5fb60322afd68.png","video":"https://breakhot.com/apponecms/storage/default.png","created_at":"1 hour ago"}]
/// postTopics : [{"topic_id":8,"post_id":7}]

class Data {
  int _id;
  String _title;
  String _description;
  String _isFeatured;
  List<Images> _images;
  List<PostTopics> _postTopics;

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get isFeatured => _isFeatured;
  List<Images> get images => _images;
  List<PostTopics> get postTopics => _postTopics;

  Data({
      int id, 
      String title, 
      String description, 
      String isFeatured, 
      List<Images> images, 
      List<PostTopics> postTopics}){
    _id = id;
    _title = title;
    _description = description;
    _isFeatured = isFeatured;
    _images = images;
    _postTopics = postTopics;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
    _description = json["description"];
    _isFeatured = json["is_featured"];
    if (json["images"] != null) {
      _images = [];
      json["images"].forEach((v) {
        _images.add(Images.fromJson(v));
      });
    }
    if (json["postTopics"] != null) {
      _postTopics = [];
      json["postTopics"].forEach((v) {
        _postTopics.add(PostTopics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    map["description"] = _description;
    map["is_featured"] = _isFeatured;
    if (_images != null) {
      map["images"] = _images.map((v) => v.toJson()).toList();
    }
    if (_postTopics != null) {
      map["postTopics"] = _postTopics.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// topic_id : 8
/// post_id : 7

class PostTopics {
  int _topicId;
  int _postId;

  int get topicId => _topicId;
  int get postId => _postId;

  PostTopics({
      int topicId, 
      int postId}){
    _topicId = topicId;
    _postId = postId;
}

  PostTopics.fromJson(dynamic json) {
    _topicId = json["topic_id"];
    _postId = json["post_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["topic_id"] = _topicId;
    map["post_id"] = _postId;
    return map;
  }

}

/// image_id : 7
/// image : "https://breakhot.com/apponecms/storage/posts/5fb60322afd68.png"
/// video : "https://breakhot.com/apponecms/storage/default.png"
/// created_at : "1 hour ago"

class Images {
  int _imageId;
  String _image;
  String _video;
  String _createdAt;

  int get imageId => _imageId;
  String get image => _image;
  String get video => _video;
  String get createdAt => _createdAt;

  Images({
      int imageId, 
      String image, 
      String video, 
      String createdAt}){
    _imageId = imageId;
    _image = image;
    _video = video;
    _createdAt = createdAt;
}

  Images.fromJson(dynamic json) {
    _imageId = json["image_id"];
    _image = json["image"];
    _video = json["video"];
    _createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["image_id"] = _imageId;
    map["image"] = _image;
    map["video"] = _video;
    map["created_at"] = _createdAt;
    return map;
  }

}
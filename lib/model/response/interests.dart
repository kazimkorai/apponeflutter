// /// id : null
// /// name : "Gaming"
//
// class Interests {
//   dynamic _id;
//   String _name;
//
//   dynamic get id => _id;
//   String get name => _name;
//
//   Interests({
//       dynamic id,
//       String name}){
//     _id = id;
//     _name = name;
// }
//
//   Interests.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
//
// }
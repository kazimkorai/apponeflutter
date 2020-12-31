// // To parse this JSON data, do
// //
// //     final welcome = welcomeFromJson(jsonString);
//
// import 'dart:convert';
//
// Countries welcomeFromJson(String str) => Countries.fromJson(json.decode(str));
//
// String welcomeToJson(Countries data) => json.encode(data.toJson());
//
// class Countries {
//   Countries({
//     this.data,
//   });
//
//   List<Datum> data;
//
//   factory Countries.fromJson(Map<String, dynamic> json) => Countries(
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   Datum({
//     this.id,
//     this.sortname,
//     this.name,
//     this.phonecode,
//   });
//
//   int id;
//   String sortname;
//   String name;
//   String phonecode;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     sortname: json["sortname"],
//     name: json["name"],
//     phonecode: json["phonecode"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "sortname": sortname,
//     "name": name,
//     "phonecode": phonecode,
//   };
// }

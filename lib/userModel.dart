
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String status;
  String message;
  List<Datum> data;

  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  List<String> subjectCategory;
  String? id;
  String? email;
  String? password;
  String? fullName;
  String? appKey;
  DateTime? dateOfBirth;
  String? gender;
  bool? agreeToMarketing;
  bool? corresPond;
  double? latitude;
  double? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    required this.subjectCategory,
    required this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.appKey,
    required this.dateOfBirth,
    required this.gender,
    required this.agreeToMarketing,
    this.corresPond,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    subjectCategory: List<String>.from(json["SubjectCategory"].map((x) => x)),
    id: json["_id"],
    email: json["email"],
    password: json["password"],
    fullName: json["fullName"],
    appKey: json["AppKey"],
    dateOfBirth:json["dateOfBirth"]==null?json["dateOfBirth"]: DateTime.parse(json["dateOfBirth"]),
    gender: json["Gender"],
    agreeToMarketing: json["agreeToMarketing"]??false,
    corresPond: json["corresPond"]??false,
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "SubjectCategory": List<dynamic>.from(subjectCategory.map((x) => x)),
    "_id": id,
    "email": email,
    "password": password,
    "fullName": fullName,
    "AppKey": appKey,
    "dateOfBirth": dateOfBirth.toString(),
    "Gender": gender,
    "agreeToMarketing": agreeToMarketing,
    "corresPond": corresPond,
    "latitude": latitude,
    "longitude": longitude,
    "createdAt": createdAt.toString(),
    "updatedAt": updatedAt.toString(),
    "__v": v,
  };
}

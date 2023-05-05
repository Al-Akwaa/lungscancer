// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromMap(String str) => User.fromMap(jsonDecode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  User({
    this.id,
    this.userName,
    this.userEmail,
    this.userPassword,
    this.userRole,
    this.images,
  });

  int? id;
  String? userName;
  String? userEmail;
  String? userPassword;
  String? userRole;
  List<dynamic>? images;

  User copyWith({
    int? id,
    String? userName,
    String? userEmail,
    String? userPassword,
    String? userRole,
    List<dynamic>? images,
  }) =>
      User(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        userEmail: userEmail ?? this.userEmail,
        userPassword: userPassword ?? this.userPassword,
        userRole: userRole ?? this.userRole,
        images: images ?? this.images,
      );

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    userName: json["userName"],
    userEmail: json["userEmail"],
    userPassword: json["userPassword"],
    userRole: json["userRole"],
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "userName": userName,
    "userEmail": userEmail,
    "userPassword": userPassword,
    "userRole": userRole,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
  };

void ClearUserData(){
  userName=null;
  userEmail=null;
  id=null;
  userPassword=null;
  userRole=null;
  images=null;
}
// bool get isAuth => userName != null;
bool get isAuth => userName != null;
}


/*
void ClearUserData(){
  userName=null;
  userEmail=null;
  id=null;
  userEmail=null;
  userPassword=null;
  userRole=null;
  images=null;
}
// bool get isAuth => userName != null;
bool get isAuth => userName == null;*/

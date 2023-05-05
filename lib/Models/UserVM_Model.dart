// To parse this JSON data, do
//
//     final userVm = userVmFromMap(jsonString);

import 'dart:convert';

UserVm userVmFromMap(String str) => UserVm.fromMap(json.decode(str));

String userVmToMap(UserVm data) => json.encode(data.toMap());

class UserVm {
  UserVm({
    this.userEmail,
    this.userPassword,
  });

  String? userEmail;
  String? userPassword;

  UserVm copyWith({
    String? userEmail,
    String? userPassword,
  }) =>
      UserVm(
        userEmail: userEmail ?? this.userEmail,
        userPassword: userPassword ?? this.userPassword,
      );

  factory UserVm.fromMap(Map<String, dynamic> json) => UserVm(
    userEmail: json["userEmail"],
    userPassword: json["userPassword"],
  );

  Map<String, dynamic> toMap() => {
    "userEmail": userEmail,
    "userPassword": userPassword,
  };
}

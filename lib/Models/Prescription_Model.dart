// To parse this JSON data, do
//
//     final prescription = prescriptionFromJson(jsonString);

import 'dart:convert';

Prescription prescriptionFromJson(String str) => Prescription.fromJson(json.decode(str));

String prescriptionToJson(Prescription data) => json.encode(data.toJson());

class Prescription {
  int? id;
  String? medicineName;
  String? dosage;
  Diagnosis? diagnosis;

  Prescription({
    this.id,
    this.medicineName,
    this.dosage,
    this.diagnosis,
  });

  Prescription copyWith({
    int? id,
    String? medicineName,
    String? dosage,
    Diagnosis? diagnosis,
  }) =>
      Prescription(
        id: id ?? this.id,
        medicineName: medicineName ?? this.medicineName,
        dosage: dosage ?? this.dosage,
        diagnosis: diagnosis ?? this.diagnosis,
      );

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
    id: json["id"],
    medicineName: json["medicineName"],
    dosage: json["dosage"],
    diagnosis: json["diagnosis"] == null ? null : Diagnosis.fromJson(json["diagnosis"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "medicineName": medicineName,
    "dosage": dosage,
    "diagnosis": diagnosis?.toJson(),
  };
}

class Diagnosis {
  int? id;
  String? userName;
  String? otherInfo;

  Diagnosis({
    this.id,
    this.userName,
    this.otherInfo,
  });

  Diagnosis copyWith({
    int? id,
    String? userName,
    String? otherInfo,
  }) =>
      Diagnosis(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        otherInfo: otherInfo ?? this.otherInfo,
      );

  factory Diagnosis.fromJson(Map<String, dynamic> json) => Diagnosis(
    id: json["id"],
    userName: json["userName"],
    otherInfo: json["otherInfo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "otherInfo": otherInfo,
  };
}
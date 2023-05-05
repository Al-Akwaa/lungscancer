// To parse this JSON data, do
//
//     final prediction = predictionFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

import 'package:lungscancer/Models/Doctor_Model.dart';
import 'package:lungscancer/Models/Image_Model.dart';
import 'package:lungscancer/Models/Prescription_Model.dart';
import 'package:lungscancer/Models/User_Model.dart';

Prediction predictionFromJson(String str) => Prediction.fromJson(json.decode(str));

String predictionToJson(Prediction data) => json.encode(data.toJson());

class Prediction {
  int? id;
  String? result;
  DateTime? predictionDate;
  ImageModel? image;
  User? user;
  Doctor? doctor;
  Prescription? prescription;

  Prediction({
    this.id,
    this.result,
    this.predictionDate,
    this.image,
    this.user,
    this.doctor,
    this.prescription,
  });

  Prediction copyWith({
    int? id,
    String? result,
    DateTime? predictionDate,
    ImageModel? image,
    User? user,
    Doctor? doctor,
    Prescription? prescription,
  }) =>
      Prediction(
        id: id ?? this.id,
        result: result ?? this.result,
        predictionDate: predictionDate ?? this.predictionDate,
        image: image ?? this.image,
        user: user ?? this.user,
        doctor: doctor ?? this.doctor,
        prescription: prescription ?? this.prescription,
      );

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
    id: json["id"],
    result: json["result"],
    predictionDate: json["predictionDate"] == null ? null : DateTime.parse(json["predictionDate"]),
    image: json["image"] == null ? null : ImageModel.fromMap(json["image"]),
    user: json["user"] == null ? null : User.fromMap(json["user"]),
    doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
    prescription: json["prescription"] == null ? null : Prescription.fromJson(json["prescription"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "result": result,
    "predictionDate": predictionDate?.toIso8601String(),
    "image": image?.toMap(),
    "user": user?.toMap(),
    "doctor": doctor?.toJson(),
    "prescription": prescription?.toJson(),
  };
}






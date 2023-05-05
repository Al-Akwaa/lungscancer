// To parse this JSON data, do
//
//     final imageModel = imageModelFromMap(jsonString);

import 'dart:convert';
import 'dart:typed_data';

ImageModel imageModelFromMap(String str) => ImageModel.fromMap(json.decode(str));

String imageModelToMap(ImageModel data) => json.encode(data.toMap());


class ImageModel {
  ImageModel({
    this.id,
    this.fileName,
    this.filePath,
    this.uploadDate,
    this.userId,
    this.patientId,
    this.patient,
    this.user,
  });

  dynamic id;
  String? fileName;
  Uint8List? filePath;
  DateTime? uploadDate;
  int? userId;
  dynamic patientId;
  dynamic patient;
  dynamic user;

  ImageModel copyWith({
    dynamic id,
    String? fileName,
    Uint8List? filePath,
    DateTime? uploadDate,
    int? userId,
    dynamic patientId,
    dynamic patient,
    dynamic user,
  }) =>
      ImageModel(
        id: id ?? this.id,
        fileName: fileName ?? this.fileName,
        filePath: filePath ?? this.filePath,
        uploadDate: uploadDate ?? this.uploadDate,
        userId: userId ?? this.userId,
        patientId: patientId ?? this.patientId,
        patient: patient ?? this.patient,
        user: user ?? this.user,
      );

  factory ImageModel.fromMap(Map<String, dynamic> json) => ImageModel(
    id: json["id"],
    fileName: json["fileName"],
    filePath: json["filePath"] == null ? null : Uint8List.fromList(List<int>.from(json["filePath"].map((x) => x))),
    uploadDate: json["uploadDate"] == null ? null : DateTime.parse(json["uploadDate"]),
    userId: json["userId"],
    patientId: json["patientId"],
    patient: json["patient"],
    user: json["user"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "fileName": fileName,
    "filePath": filePath == null ? null : List<dynamic>.from(filePath!.map((x) => x)),
    "uploadDate": uploadDate?.toIso8601String(),
    "userId": userId,
    "patientId": patientId,
    "patient": patient,
    "user": user,
  };
}

/*
class ImageModel {
  ImageModel({
    this.id,
    this.fileName,
    this.filePath,
    this.uploadDate,
    this.userId,
    this.patientId,
    this.patient,
    this.user,
  });

  dynamic id;
  String? fileName;
  List<int>? filePath;
  DateTime? uploadDate;
  int? userId;
  dynamic patientId;
  dynamic patient;
  dynamic user;

  ImageModel copyWith({
    dynamic id,
    String? fileName,
    List<int>? filePath,
    DateTime? uploadDate,
    int? userId,
    dynamic patientId,
    dynamic patient,
    dynamic user,
  }) =>
      ImageModel(
        id: id ?? this.id,
        fileName: fileName ?? this.fileName,
        filePath: filePath ?? this.filePath,
        uploadDate: uploadDate ?? this.uploadDate,
        userId: userId ?? this.userId,
        patientId: patientId ?? this.patientId,
        patient: patient ?? this.patient,
        user: user ?? this.user,
      );

  factory ImageModel.fromMap(Map<String, dynamic> json) => ImageModel(
    id: json["id"],
    fileName: json["fileName"],
    filePath: json["filePath"] == null ? [] : List<int>.from(json["filePath"]!.map((x) => x)),
    uploadDate: json["uploadDate"] == null ? null : DateTime.parse(json["uploadDate"]),
    userId: json["userId"],
    patientId: json["patientId"],
    patient: json["patient"],
    user: json["user"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "fileName": fileName,
    "filePath": filePath == null ? [] : List<dynamic>.from(filePath!.map((x) => x)),
    "uploadDate": uploadDate?.toIso8601String(),
    "userId": userId,
    "patientId": patientId,
    "patient": patient,
    "user": user,
  };
}
*/

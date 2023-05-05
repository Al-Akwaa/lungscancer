class Doctor {
  int? id;
  String? doctorName;
  String? doctorEmail;
  String? doctorPassword;
  String? doctorSpecialty;

  Doctor({
    this.id,
    this.doctorName,
    this.doctorEmail,
    this.doctorPassword,
    this.doctorSpecialty,
  });

  Doctor copyWith({
    int? id,
    String? doctorName,
    String? doctorEmail,
    String? doctorPassword,
    String? doctorSpecialty,
  }) =>
      Doctor(
        id: id ?? this.id,
        doctorName: doctorName ?? this.doctorName,
        doctorEmail: doctorEmail ?? this.doctorEmail,
        doctorPassword: doctorPassword ?? this.doctorPassword,
        doctorSpecialty: doctorSpecialty ?? this.doctorSpecialty,
      );

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["id"],
    doctorName: json["doctorName"],
    doctorEmail: json["doctorEmail"],
    doctorPassword: json["doctorPassword"],
    doctorSpecialty: json["doctorSpecialty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "doctorName": doctorName,
    "doctorEmail": doctorEmail,
    "doctorPassword": doctorPassword,
    "doctorSpecialty": doctorSpecialty,
  };
}

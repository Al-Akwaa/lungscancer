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

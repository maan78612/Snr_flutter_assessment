class BeneficiaryModel {
  String id;
  String name;
  String number;
  String userId;
  double monthlyLimit;
  double remaining;
  DateTime createdAt;
  DateTime updatedAt;

  BeneficiaryModel({
    required this.id,
    required this.name,
    required this.number,
    required this.userId,
    required this.monthlyLimit,
    required this.remaining,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) =>
      BeneficiaryModel(
        id: json["_id"],
        name: json["name"],
        number: json["number"],
        userId: json["user_id"],
        monthlyLimit: double.parse(json["monthlyLimit"].toString()),
        remaining: double.parse(json["remaining"].toString()),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "number": number,
        "user_id": userId,
        "monthlyLimit": monthlyLimit,
        "remaining": remaining,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

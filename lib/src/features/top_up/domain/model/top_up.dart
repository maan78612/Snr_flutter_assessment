import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';

class Transaction {
  String id;
  String userId;
  BeneficiaryModel beneficiary;
  int amount;
  String purpose;
  String note;
  DateTime createdAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.beneficiary,
    required this.amount,
    required this.purpose,
    required this.note,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["_id"],
        userId: json["user_id"],
        beneficiary: BeneficiaryModel.fromJson(json["beneficiary_id"]),
        amount: json["amount"],
        purpose: json["purpose"],
        note: json["note"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "beneficiary_id": beneficiary.toJson(),
        "amount": amount,
        "purpose": purpose,
        "note": note,
        "createdAt": createdAt.toIso8601String(),
      };
}

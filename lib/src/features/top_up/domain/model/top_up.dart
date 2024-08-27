class Transaction {
  String id;
  int userId;
  int beneficiaryId;
  double amount;
  DateTime createdAt;
  String purpose;
  String? note;

  Transaction({
    required this.id,
    required this.userId,
    required this.beneficiaryId,
    required this.amount,
    required this.createdAt,
    required this.purpose,
    this.note,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'],
      beneficiaryId: json['beneficiary_id'],
      amount: json['amount'],
      createdAt: DateTime.parse(json['created_at']),
      purpose: json['purpose'],
      note: json['note'],
    );
  }

  // toJson: converts a Transaction to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'beneficiary_id': beneficiaryId,
      'amount': amount,
      'created_at': createdAt.toIso8601String(),
      'purpose': purpose,
      'note': note,
    };
  }
}

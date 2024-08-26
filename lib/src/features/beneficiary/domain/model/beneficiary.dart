class BeneficiaryModel {
  final int id;
  final String name;
  final String number;
  final String userId;
  final double monthlyLimit;
  final double remaining;
  final DateTime createdAt;

  BeneficiaryModel({
    required this.id,
    required this.name,
    required this.number,
    required this.userId,
    required this.monthlyLimit,
    required this.remaining,
    required this.createdAt,
  });

  // Factory constructor to create an instance from JSON
  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) {
    return BeneficiaryModel(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      userId: json['user_id'],
      monthlyLimit: json['monthly_limit'],
      remaining: json['remaining'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'user_id': userId,
      'monthly_limit': monthlyLimit,
      'remaining': remaining,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

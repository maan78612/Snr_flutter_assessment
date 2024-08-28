import 'package:technical_assessment_flutter/src/core/enums/user_status.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final UserStatus status;
  final double availableBalance;
  final double remainingMonthlyLimit;
  final String currentMonth;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.availableBalance,
    required this.remainingMonthlyLimit,
    required this.currentMonth,
  });

  // Example of a factory constructor to create a UserAccount from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      status: UserStatus.values[json['status']],
      availableBalance: json['availableBalance'],
      remainingMonthlyLimit: json['remainingMonthlyLimit'],
      currentMonth: json['currentMonth'],
    );
  }

  // Method to convert the UserAccount to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'status': status.index,
      'availableBalance': availableBalance,
      'remainingMonthlyLimit': remainingMonthlyLimit,
      'currentMonth': currentMonth,
    };
  }
}

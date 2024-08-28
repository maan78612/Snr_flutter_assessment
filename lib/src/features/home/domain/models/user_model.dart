import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_assessment_flutter/src/core/enums/user_status.dart';

class UserModel {
  String name;
  String id;
  String email;
  UserStatus status;
  double remainingMonthlyLimit;
  String currentMonth;
  double availableBalance;
  DateTime createdAt;

  UserModel({
    required this.name,
    required this.id,
    required this.email,
    required this.status,
    required this.remainingMonthlyLimit,
    required this.currentMonth,
    required this.availableBalance,
    required this.createdAt,
  });

  // Factory constructor to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        id: json["_id"],
        email: json["email"],
        status: _mapStringToUserStatus(json['status']),
        remainingMonthlyLimit:
            double.parse(json["remainingMonthlyLimit"].toString()),
        currentMonth: json["currentMonth"],
        availableBalance: double.parse(json["availableBalance"].toString()),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  // Helper method to map a string to the UserStatus enum
  static UserStatus _mapStringToUserStatus(String status) {
    switch (status) {
      case 'not_verified':
        return UserStatus.notVerified;
      case 'verified':
        return UserStatus.verified;
      default:
        throw Exception('Unknown UserStatus: $status');
    }
  }

  // Method to convert a UserModel instance to JSON
  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
        "email": email,
        'status': status.toString().split('.').last, // Convert enum to string
        "remainingMonthlyLimit": remainingMonthlyLimit,
        "currentMonth": currentMonth,
        "availableBalance": availableBalance,
        "createdAt": createdAt.toIso8601String(),
      };

  // copyWith method to create a new instance with modified fields
  UserModel copyWith({
    String? name,
    String? id,
    String? email,
    UserStatus? status,
    double? remainingMonthlyLimit,
    String? currentMonth,
    double? availableBalance,
    DateTime? createdAt,
  }) {
    return UserModel(
      name: name ?? this.name,
      id: id ?? this.id,
      email: email ?? this.email,
      status: status ?? this.status,
      remainingMonthlyLimit:
          remainingMonthlyLimit ?? this.remainingMonthlyLimit,
      currentMonth: currentMonth ?? this.currentMonth,
      availableBalance: availableBalance ?? this.availableBalance,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserModel.empty() {
    return UserModel(
      name: '',
      id: '',
      email: '',
      status: UserStatus.notVerified,
      // Default status
      remainingMonthlyLimit: 0.0,
      currentMonth: '',
      availableBalance: 0.0,
      createdAt: DateTime.now(), // Default to current date
    );
  }
}

class UserModelNotifier extends StateNotifier<UserModel> {
  UserModelNotifier() : super(UserModel.empty());

  void setUser(UserModel newUser) {
    state = newUser;
  }

  void updateBalance(double newBalance) {
    state = state.copyWith(availableBalance: newBalance);
  }

  void updateMonthlyLimit(double newLimit) {
    state = state.copyWith(remainingMonthlyLimit: newLimit);
  }
}

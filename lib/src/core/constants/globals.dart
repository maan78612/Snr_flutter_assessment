import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/enums/user_status.dart';
import 'package:technical_assessment_flutter/src/features/home/domain/models/user_model.dart';

const int routingDuration = 300;
double inputFieldHeight = 50.sp;
double hMargin = 24.sp;
String? fcmToken;

/* TODO: temporary users for testing*/

UserModel? user;

UserModel verifiedUser = UserModel(
  id: 1,
  name: 'Moazam',
  email: 'verified@example.com',
  status: UserStatus.verified,
  availableBalance: 1500.00,
  remainingMonthlyLimit: 500.00,
  currentMonth: '08-2024',
);

UserModel notVerifiedUser = UserModel(
  id: 2,
  name: 'Abdul raheem',
  email: 'janesmith@example.com',
  status: UserStatus.notVerified,
  availableBalance: 1000.00,
  remainingMonthlyLimit: 300.00,
  currentMonth: '08-2024',
);

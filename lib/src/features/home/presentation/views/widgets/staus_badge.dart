import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/core/constants/images.dart';
import 'package:technical_assessment_flutter/src/core/enums/user_status.dart';

class StatusBadge extends StatelessWidget {
  final UserStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.sp),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(3.r)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 18.sp,
            height: 18.sp,
            child: Image.asset(_statusToImage(status)),
          ),
          2.horizontalSpace,
          Text(
            _statusToString(status),
            style:
                PoppinsStyles.medium.copyWith(color: _statusToColor(status),fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  static String _statusToString(UserStatus status) {
    switch (status) {
      case UserStatus.verified:
        return 'Verified';
      case UserStatus.notVerified:
        return 'Not verified';
      default:
        return "";
    }
  }

  static Color _statusToColor(UserStatus status) {
    switch (status) {
      case UserStatus.verified:
        return AppColors.greenColor;
      case UserStatus.notVerified:
        return AppColors.redColor;
      default:
        return AppColors.primaryColor;
    }
  }

  static String _statusToImage(UserStatus status) {
    switch (status) {
      case UserStatus.verified:
        return AppImages.verified;
      case UserStatus.notVerified:
        return AppImages.notVerified;
      default:
        return AppImages.notVerified;
    }
  }
}

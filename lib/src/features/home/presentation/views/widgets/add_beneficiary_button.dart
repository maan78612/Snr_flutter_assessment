import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';

class AddBeneficiaryButton extends StatelessWidget {
  const AddBeneficiaryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 16.sp),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(16.sp)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: AppColors.whiteColor, size: 24.sp),
            SizedBox(width: 5.sp), // Equivalent to 5.horizontalSpace
            Text(
              "Add Beneficiary",
              style: PoppinsStyles.medium.copyWith(
                fontSize: 18.sp,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
      color: AppColors.primaryColor,
      onPressed: () {},
      // onPressed: () => CustomNavigation().push(const CreatePostView()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_navigation.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/presentation/viewmodels/beneficiary_viewmodel.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/presentation/views/add_beneficiary/add_beneficiary.dart';

class AddBeneficiaryButton extends StatelessWidget {
  final ChangeNotifierProvider<BeneficiaryViewModel>
      beneficiaryViewModelProvider;

  const AddBeneficiaryButton(
      {super.key, required this.beneficiaryViewModelProvider});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 16.sp),
        margin: EdgeInsets.only(right: 5.sp),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(16.sp)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: AppColors.whiteColor, size: 20.sp),
            SizedBox(width: 5.sp), // Equivalent to 5.horizontalSpace
            Text(
              "Add Beneficiary",
              style: PoppinsStyles.medium.copyWith(
                fontSize: 16.sp,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
      color: AppColors.primaryColor,
      onPressed: () => CustomNavigation().push(AddBeneficiary(
        beneficiaryViewModelProvider: beneficiaryViewModelProvider,
      )),
    );
  }
}

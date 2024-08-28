import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_button.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_inkwell.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_navigation.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/core/utilities/bottom_sheet.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/presentation/viewmodels/beneficiary_viewmodel.dart';

class DeleteButton extends ConsumerWidget {
  final BeneficiaryModel beneficiary;
  final ChangeNotifierProvider<BeneficiaryViewModel>
      beneficiaryViewModelProvider;

  const DeleteButton(
      {super.key,
      required this.beneficiaryViewModelProvider,
      required this.beneficiary});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(

      right: 2.sp,
      top: -8.sp,
      child: CommonInkWell(
        onTap: () async {
          bool? isDelete =
              await BottomSheetUtils.show(deleteBottomSheet(), context);

          if (isDelete ?? false) {
            ref
                .read(beneficiaryViewModelProvider)
                .deleteBeneficiary(beneficiary);
          }
        },
        child: Container(
          padding: EdgeInsets.all(2.sp),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.redColor),
          ),
          child: Icon(
            Icons.delete_forever,
            color: AppColors.redColor,
            size: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget deleteBottomSheet() {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          24.verticalSpace,
          Center(
            child: Text(
              'Delete Beneficiary',
              style: PoppinsStyles.semiBold.copyWith(fontSize: 18.sp),
            ),
          ),
          24.verticalSpace,
          const Divider(color: AppColors.borderColor),
          24.verticalSpace,
          Text(
            'Are you sure you want to delete ${beneficiary.name} as  beneficiary',
            textAlign: TextAlign.center,
            style: PoppinsStyles.medium.copyWith(fontSize: 13.sp),
          ),
          30.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    height: 41.h,
                    bgColor: AppColors.whiteColor,
                    textColor: AppColors.primaryColor,
                    title: "Yes",
                    textStyle: PoppinsStyles.medium.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 14.sp,
                    ),
                    borderColor: AppColors.primaryColor,
                    onPressed: () {
                      CustomNavigation().pop(true);
                    },
                  ),
                ),
                SizedBox(width: 10.sp),
                Expanded(
                  child: CustomButton(
                    height: 37.h,
                    bgColor: AppColors.primaryColor,
                    textColor: AppColors.whiteColor,
                    textStyle: PoppinsStyles.medium.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 14.sp,
                    ),
                    title: "No",
                    onPressed: () {
                      CustomNavigation().pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          24.verticalSpace,
        ],
      ),
    );
  }
}

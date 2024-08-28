import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_button.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_navigation.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/viewmodels/top_up_viewmodel.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/views/top_up_view.dart'; // Update with actual path

class BeneficiaryCard extends StatelessWidget {
  final BeneficiaryModel beneficiary;
  final ChangeNotifierProvider<TopUpViewModel> topUpViewModelProvider;

  const BeneficiaryCard({
    super.key,
    required this.beneficiary,
    required this.topUpViewModelProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      /// every card will get (38% - 10.sp) of remaining width
      width: (0.38.sw) - 10.sp,
      padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 8.sp),
      margin: EdgeInsets.only(right: 10.sp, bottom: 20.sp),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            beneficiary.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: PoppinsStyles.semiBold.copyWith(
              fontSize: 14.sp,
              color: AppColors.primaryColor,
            ),
          ),
          20.verticalSpace,
          Text(
            beneficiary.number,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: PoppinsStyles.semiBold.copyWith(
              fontSize: 12.sp,
              color: AppColors.greyColor,
            ),
          ),
          20.verticalSpace,
          CustomButton(
            title: "Recharge Now",
            height: 34.h,
            textStyle: PoppinsStyles.medium.copyWith(
              fontSize: 11.sp,
              color: AppColors.whiteColor,
            ),
            onPressed: () {
              CustomNavigation().push(TopUpView(
                beneficiary: beneficiary,
                topUpViewModelProvider: topUpViewModelProvider,
              ));
            },
            bgColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/viewmodels/top_up_viewmodel.dart';

class PurposeDropDown extends ConsumerWidget {
  final ChangeNotifierProvider<TopUpViewModel> topUpViewModelProvider;

  const PurposeDropDown({super.key, required this.topUpViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topUpViewModel = ref.watch(topUpViewModelProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.verticalSpace,
        heading('Purpose'),
        4.verticalSpace,
        DropdownButtonFormField<String>(
          value: topUpViewModel.selectedPurpose,
          dropdownColor: AppColors.whiteColor,
          hint: Text(
            "Select Purpose of payment",
            style: PoppinsStyles.regular.copyWith(color: AppColors.hintColor),
          ),
          items: topUpViewModel.purposes.map((purpose) {
            return DropdownMenuItem(
              value: purpose,
              child: Text(purpose),
            );
          }).toList(),
          onChanged: (value) {
            topUpViewModel.selectPurpose(value ?? "");
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: AppColors.redColor,
                width: 1,
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
          ),
        ),
      ],
    );
  }

  Widget heading(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Text(
        title,
        style: PoppinsStyles.semiBold.copyWith(fontSize: 16.sp),
      ),
    );
  }
}

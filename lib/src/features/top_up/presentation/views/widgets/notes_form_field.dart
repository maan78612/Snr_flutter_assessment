import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/viewmodels/top_up_viewmodel.dart';

class NotesFormField extends ConsumerWidget {
  final ChangeNotifierProvider<TopUpViewModel> topUpViewModelProvider;

  const NotesFormField({super.key, required this.topUpViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topUpViewModel = ref.watch(topUpViewModelProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.verticalSpace,
        heading('Notes'),
        4.verticalSpace,
        TextFormField(
          controller: topUpViewModel.notesController,
          maxLines: 7,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            hintText: "Enter any additional notes",
            hintStyle: PoppinsStyles.regular.copyWith(
              fontSize: 15.sp,
              color: AppColors.hintColor,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 13.sp,
              vertical: 10.sp,
            ),
            filled: true,
            fillColor: AppColors.whiteColor,
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
          ),
          style: PoppinsStyles.regular.copyWith(fontSize: 15.sp),
        )
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

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_inkwell.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/viewmodels/top_up_viewmodel.dart';

class AmountGridView extends ConsumerWidget {
  final ChangeNotifierProvider<TopUpViewModel> topUpViewModelProvider;

  const AmountGridView({super.key, required this.topUpViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topUpViewModel = ref.watch(topUpViewModelProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.verticalSpace,
        heading('Select Amount'),
        8.verticalSpace,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of chips per row
              crossAxisSpacing: 8.sp, // Horizontal spacing
              mainAxisSpacing: 16.sp,
              childAspectRatio: 3.3 // Vertical spacing
              ),
          itemCount: topUpViewModel.topUpAmounts.length,
          itemBuilder: (context, index) {
            final amount = topUpViewModel.topUpAmounts[index];
            return CommonInkWell(
              onTap: () => topUpViewModel.selectTopUpAmount(amount),
              child: Container(
                decoration: BoxDecoration(
                    color: topUpViewModel.selectedAmount == amount
                        ? AppColors.primaryColor
                        :Color(0xffFAF9F6),
                    border: Border.all(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(4.r))),
                child: Center(
                  child: Text(
                    '${amount.toInt()} AED',
                    style: PoppinsStyles.medium.copyWith(
                        fontSize: 12.sp,
                        color: topUpViewModel.selectedAmount == amount
                            ? AppColors.whiteColor
                            : AppColors.primaryColor), // Adjust text size
                  ),
                ),
              ),
            );
          },
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

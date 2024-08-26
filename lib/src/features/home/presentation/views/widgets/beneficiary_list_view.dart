import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/features/home/presentation/viewmodels/home_viewmodel.dart';

class BeneficiaryListView extends ConsumerWidget {
  final ChangeNotifierProvider<HomeViewModel> homeViewModelProvider;

  const BeneficiaryListView({super.key, required this.homeViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.watch(homeViewModelProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(5, (index) {
            return Container(
              width: 0.4.sw,
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: const Color(0xffFAF9F6),
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 3)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "post.text",
                    style: PoppinsStyles.regular.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.greyColor,
                    ),
                  ),
                  20.verticalSpace,
                  20.verticalSpace,
                  Text(
                    "Images",
                    style: PoppinsStyles.bold.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

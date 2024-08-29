import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/core/constants/globals.dart';
import 'package:technical_assessment_flutter/src/core/constants/images.dart';
import 'package:technical_assessment_flutter/src/features/home/presentation/views/widgets/staus_badge.dart';

class WelcomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const WelcomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userModelProvider);
    return ClipPath(
      clipper: WaveClipperOne(
        flip: true,
        reverse: false,
      ),
      child: Container(
        color: AppColors.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back!",
                      style: PoppinsStyles.medium.copyWith(
                          fontSize: 18.sp,
                          height: 1,
                          color: AppColors.whiteColor),
                    ),
                    7.verticalSpace,
                    Text(
                      user.name,
                      style: PoppinsStyles.bold.copyWith(
                          fontSize: 24.sp, color: AppColors.whiteColor),
                    ),
                  ],
                ),
                const Spacer(),
                Opacity(
                  opacity: 0.6,
                  child: Image.asset(AppImages.logo,
                      width: 80.w,
                      fit: BoxFit.contain,
                      color: AppColors.whiteColor),
                ),
              ],
            ),
            40.verticalSpace,
            Row(
              children: [
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Balance : ",
                        style: PoppinsStyles.medium.copyWith(
                            fontSize: 18.sp,
                            height: 1.3,
                            color: AppColors.whiteColor),
                      ),
                      TextSpan(
                        text: "${user.availableBalance.toStringAsFixed(1)} AED",
                        style: PoppinsStyles.bold.copyWith(
                            fontSize: 18.sp, color: AppColors.whiteColor),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                StatusBadge(status: user.status),
              ],
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(180.h); // Adjust the height as needed
}

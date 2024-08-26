import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/core/constants/images.dart';

class WelcomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WelcomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
                Image.asset(AppImages.logo,
                    width: 80.w,
                    fit: BoxFit.contain,
                    color: AppColors.whiteColor),
                10.horizontalSpace,
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Welcome Back!\n",
                        style: PoppinsStyles.medium.copyWith(
                            fontSize: 18.sp,
                            height: 1.3,
                            color: AppColors.whiteColor),
                      ),
                      TextSpan(
                        text: "Abdul Rehman",
                        style: PoppinsStyles.extraBold.copyWith(
                            fontSize: 24.sp, color: AppColors.whiteColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
            20.verticalSpace,
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
                    text: "3400 Aed",
                    style: PoppinsStyles.bold
                        .copyWith(fontSize: 18.sp, color: AppColors.whiteColor),
                  ),
                ],
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(160.h); // Adjust the height as needed
}

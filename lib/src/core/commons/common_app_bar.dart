
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_inkwell.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function? onTap;
  final PreferredSizeWidget? bottom;

  const CommonAppBar({
    super.key,
    required this.title,
    this.bottom,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leading: onTap != null
          ? CommonInkWell(
              onTap: () {
                onTap!();
              },
              child: Padding(
                padding: EdgeInsets.only(right: 8.sp),
                child:
                    const Icon(Icons.arrow_back, color: AppColors.blackColor),
              ),
            )
          : const SizedBox.shrink(),
      title: Text(
        title,
        style: PoppinsStyles.medium.copyWith(fontSize: 20.sp),
      ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

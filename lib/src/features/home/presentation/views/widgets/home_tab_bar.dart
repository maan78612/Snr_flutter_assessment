import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_inkwell.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/core/constants/globals.dart';
import 'package:technical_assessment_flutter/src/core/enums/tab_bar_enum.dart';
import 'package:technical_assessment_flutter/src/features/home/presentation/viewmodels/home_viewmodel.dart';

class HomeTabBar extends ConsumerWidget {
  final ChangeNotifierProvider<HomeViewModel> homeViewModelProvider;

  const HomeTabBar({super.key, required this.homeViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.watch(homeViewModelProvider);

    return Container(
      padding: EdgeInsets.all(8.sp),
      margin: EdgeInsets.symmetric(horizontal: hMargin),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: TabBarEnum.values.map((status) {
            return StatusButton(
              tabBarEnum: status,
              isSelected: homeViewModel.selectedTab == status,
              onTap: () => homeViewModel.setTabView(status),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class StatusButton extends StatelessWidget {
  final TabBarEnum tabBarEnum;
  final bool isSelected;
  final VoidCallback onTap;

  const StatusButton({
    super.key,
    required this.tabBarEnum,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.sp),
        height: 40.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
        child: CommonInkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              statusToString(tabBarEnum),
              style: PoppinsStyles.regular.copyWith(
                fontSize: 12.sp,
                color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String statusToString(TabBarEnum tabBarEnum) {
    switch (tabBarEnum) {
      case TabBarEnum.recharge:
        return 'Mobile Recharge';
      case TabBarEnum.history:
        return 'History';

      default:
        return "";
    }
  }
}

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
    final selectedIndex = TabBarEnum.values.indexOf(homeViewModel.selectedTab);

    return Container(
      padding: EdgeInsets.all(4.sp),
      margin: EdgeInsets.symmetric(horizontal: hMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32.r)),
        color: AppColors.primaryColor.withOpacity(0.2),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: (MediaQuery.of(context).size.width - (2 * hMargin)) /
                TabBarEnum.values.length *
                selectedIndex,

            /// Adjust the width calculation to ensure it fits on larger screens
            width: (MediaQuery.of(context).size.width - (2 * hMargin)) /
                    TabBarEnum.values.length -
                8.sp,
            height: 40.h,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(24.r)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: TabBarEnum.values.map((status) {
              return StatusButton(
                tabBarEnum: status,
                isSelected: homeViewModel.selectedTab == status,
                onTap: () => homeViewModel.setTabView(status),
              );
            }).toList(),
          ),
        ],
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
      child: CommonInkWell(
        onTap: onTap,
        child: SizedBox(
          height: 40.sp,
          child: Center(
            child: Text(
              statusToString(tabBarEnum),
              style: isSelected
                  ? PoppinsStyles.medium.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.whiteColor,
                    )
                  : PoppinsStyles.regular.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.blackColor,
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

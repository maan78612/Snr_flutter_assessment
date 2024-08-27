import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/commons/loader.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/core/constants/globals.dart';
import 'package:technical_assessment_flutter/src/core/constants/images.dart';
import 'package:technical_assessment_flutter/src/core/enums/tab_bar_enum.dart';
import 'package:technical_assessment_flutter/src/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:technical_assessment_flutter/src/features/home/presentation/views/widgets/add_beneficiary_button.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/presentation/views/beneficiary_list_view.dart';
import 'package:technical_assessment_flutter/src/features/home/presentation/views/widgets/home_tab_bar.dart';
import 'package:technical_assessment_flutter/src/features/home/presentation/views/widgets/welcome_app_bar.dart';

class HomeScreen extends ConsumerWidget {
  final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
    return HomeViewModel();
  });

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.watch(homeViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const WelcomeAppBar(),
      body: Column(
        children: [
          HomeTabBar(homeViewModelProvider: homeViewModelProvider),
          30.verticalSpace,
          if (homeViewModel.selectedTab == TabBarEnum.recharge)
            const BeneficiaryListView()
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}

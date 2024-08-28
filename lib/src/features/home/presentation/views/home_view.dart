import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/commons/loader.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/enums/tab_bar_enum.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/presentation/viewmodels/beneficiary_viewmodel.dart';
import 'package:technical_assessment_flutter/src/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:technical_assessment_flutter/src/features/home/presentation/views/widgets/add_beneficiary_button.dart';
import 'package:technical_assessment_flutter/src/features/home/presentation/views/widgets/home_tab_bar.dart';
import 'package:technical_assessment_flutter/src/features/home/presentation/views/widgets/mobile_recharge.dart';
import 'package:technical_assessment_flutter/src/features/home/presentation/views/widgets/welcome_app_bar.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/viewmodels/top_up_viewmodel.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/views/top_up_history.dart';

class HomeView extends ConsumerStatefulWidget {
  HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  /// Initializing providers in Home because we need them after the home screen
  /// and they will dispose when the home screen is disposed.
  final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
    return HomeViewModel();
  });

  final topUpViewModelProvider = ChangeNotifierProvider<TopUpViewModel>((ref) {
    return TopUpViewModel();
  });

  final beneficiaryViewModelProvider =
      ChangeNotifierProvider<BeneficiaryViewModel>((ref) {
    return BeneficiaryViewModel();
  });

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider).resetMonth(ref);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = ref.watch(homeViewModelProvider);

    return CustomLoader(
      isLoading: homeViewModel.isLoading,
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
        appBar: const WelcomeAppBar(),
        body: Column(
          children: [
            HomeTabBar(homeViewModelProvider: homeViewModelProvider),
            30.verticalSpace,
            Expanded(
              child: homeViewModel.selectedTab == TabBarEnum.recharge
                  ? MobileRechargeView(
                      topUpViewModelProvider: topUpViewModelProvider,
                      beneficiaryViewModelProvider:
                          beneficiaryViewModelProvider,
                    )
                  : HistoryScreen(
                      topUpViewModelProvider: topUpViewModelProvider,
                      beneficiaryList: ref
                          .watch(beneficiaryViewModelProvider)
                          .beneficiaryList,
                    ),
            ),
          ],
        ),
        floatingActionButton: homeViewModel.selectedTab == TabBarEnum.recharge
            ? AddBeneficiaryButton(
                beneficiaryViewModelProvider: beneficiaryViewModelProvider,
              )
            : null,
      ),
    );
  }
}

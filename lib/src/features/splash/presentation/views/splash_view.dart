import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/core/constants/images.dart';
import 'package:technical_assessment_flutter/src/features/splash/presentation/viewmodels/splash_viewmodel.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with TickerProviderStateMixin {
  /// Provider for the SplashViewModel using ChangeNotifierProvider
  final _splashViewModelProvider =
      ChangeNotifierProvider<SplashViewModel>((ref) {
    return SplashViewModel();
  });

  @override
  void initState() {
    super.initState();

    /// call init method with this State as the TickerProvider
    ref.read(_splashViewModelProvider).initFunc(this);
  }

  @override
  Widget build(BuildContext context) {
    /// Watch the SplashViewModel for changes
    final splashViewModel = ref.watch(_splashViewModelProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: ScaleTransition(
          scale: splashViewModel.animation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.logo, width: 0.9.sw, fit: BoxFit.cover),
              20.verticalSpace,
              Text("Technical Assessment", style: PoppinsStyles.regular),
              14.verticalSpace,
              Text("Sr. Flutter Developer",
                  style: PoppinsStyles.extraBold.copyWith(fontSize: 24.sp)),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_button.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_input_field.dart';
import 'package:technical_assessment_flutter/src/core/commons/loader.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/core/constants/globals.dart';
import 'package:technical_assessment_flutter/src/core/constants/images.dart';
import 'package:technical_assessment_flutter/src/core/constants/text_field_validator.dart';
import 'package:technical_assessment_flutter/src/features/auth/presentation/viewmodels/login_viewmodel.dart';

class LoginView extends ConsumerWidget {
  final loginViewModelProvider = ChangeNotifierProvider<LoginViewModel>((ref) {
    return LoginViewModel();
  });

  LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginViewModel = ref.watch(loginViewModelProvider);

    return CustomLoader(
      isLoading: loginViewModel.isLoading,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hMargin),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    header(),
                    CustomInputField(
                      controller: loginViewModel.emailCon,
                      title: "Email",
                      hint: "john@email.com",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChange: (value) {
                        loginViewModel.onChange(
                            con: loginViewModel.emailCon,
                            value: value,
                            validator: TextFieldValidator.validateEmail);
                      },
                    ),
                    CustomInputField(
                      controller: loginViewModel.passwordCon,
                      title: "Password",
                      hint: "Enter password",
                      onChange: (value) {
                        loginViewModel.onChange(
                            con: loginViewModel.passwordCon,
                            value: value,
                            validator: TextFieldValidator.validatePassword);
                      },
                      obscure: true,
                    ),
                    50.verticalSpace,
                    CustomButton(
                      title: 'Login',
                      isEnable: loginViewModel.isBtnEnable,
                      bgColor: AppColors.primaryColor,
                      onPressed: () {
                        loginViewModel.login(ref);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Logo and heading
  Widget header() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        30.verticalSpace,
        Image.asset(AppImages.logo, width: 0.6.sw, fit: BoxFit.cover),
        30.verticalSpace,
        Text(
          "Please enter your account here",
          style: PoppinsStyles.regular
              .copyWith(fontSize: 14.sp, color: AppColors.greyColor),
        ),
        35.verticalSpace,
      ],
    );
  }
}

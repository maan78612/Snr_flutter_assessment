import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/commons/common_app_bar.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_button.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_input_field.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_navigation.dart';
import 'package:technical_assessment_flutter/src/core/commons/loader.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/core/constants/globals.dart';
import 'package:technical_assessment_flutter/src/core/constants/text_field_validator.dart';
import 'package:technical_assessment_flutter/src/core/enums/user_status.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/presentation/viewmodels/beneficiary_viewmodel.dart';
import 'package:technical_assessment_flutter/src/features/home/domain/models/user_model.dart';

class AddBeneficiary extends ConsumerWidget {
  final ChangeNotifierProvider<BeneficiaryViewModel>
      beneficiaryViewModelProvider;

  const AddBeneficiary({super.key, required this.beneficiaryViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beneficiaryViewModel = ref.watch(beneficiaryViewModelProvider);
    final user = ref.watch(userModelProvider);

    return CustomLoader(
      isLoading: beneficiaryViewModel.isLoading,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CommonAppBar(
          title: 'Add Beneficiary',
          onTap: () {
            beneficiaryViewModel.clearForm();
            CustomNavigation().pop();
          },
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hMargin),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  CustomInputField(
                    controller: beneficiaryViewModel.nickNameCon,
                    title: "Nick name ",
                    maxLength: 20,
                    hint: "Nick Name (max. 20 characters)",
                    keyboardType: TextInputType.emailAddress,
                    onChange: (value) {
                      beneficiaryViewModel.onChange(
                          con: beneficiaryViewModel.nickNameCon,
                          value: value,
                          validator: TextFieldValidator.validatePersonName);
                    },
                  ),
                  20.verticalSpace,
                  CustomInputField(
                    controller: beneficiaryViewModel.numberCon,
                    keyboardType: TextInputType.phone,
                    title: "Phone number",
                    prefixWidget: Text(
                      "+971",
                      style: PoppinsStyles.bold,
                    ),
                    hint: "505****55",
                    onChange: (value) {
                      beneficiaryViewModel.onChange(
                          con: beneficiaryViewModel.numberCon,
                          value: "+971$value",
                          validator: TextFieldValidator.validatePhoneNumberUAE);
                    },
                  ),
                  notes(user),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(hMargin),
          child: CustomButton(
            title: 'Add Beneficiary',
            isEnable: beneficiaryViewModel.isBtnEnable,
            bgColor: AppColors.primaryColor,
            onPressed: () {
              beneficiaryViewModel.addBeneficiary(user);
            },
          ),
        ),
      ),
    );
  }

  Widget notes(UserModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        50.verticalSpace,
        Text("Note :", style: PoppinsStyles.medium.copyWith(fontSize: 18.sp)),
        10.verticalSpace,
        infoPointsWidget(
            "You can send a maximum of ${user.status == UserStatus.verified ? '500' : '1000'} AED per month per beneficiary."),
        20.verticalSpace,
      ],
    );
  }

  Widget infoPointsWidget(String info) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "*",
          style: PoppinsStyles.regular.copyWith(
            fontSize: 22.sp,
            color: Colors.red,
          ),
        ),
        5.horizontalSpace,
        Expanded(
          child: Text(
            info,
            style: PoppinsStyles.regular.copyWith(
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}

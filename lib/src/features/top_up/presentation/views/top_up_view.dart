import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/commons/common_app_bar.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_button.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_navigation.dart';
import 'package:technical_assessment_flutter/src/core/commons/loader.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/core/constants/globals.dart';
import 'package:technical_assessment_flutter/src/core/utilities/dialog_box.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/top_up/domain/model/top_up.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/viewmodels/top_up_viewmodel.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/views/widgets/amount_grid_view.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/views/widgets/invoice.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/views/widgets/notes_form_field.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/views/widgets/puprpose_dropdown.dart';

class TopUpView extends ConsumerWidget {
  final BeneficiaryModel beneficiary;
  final ChangeNotifierProvider<TopUpViewModel> topUpViewModelProvider;

  const TopUpView(
      {super.key,
      required this.beneficiary,
      required this.topUpViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topUpViewModel = ref.watch(topUpViewModelProvider);
    return CustomLoader(
      isLoading: topUpViewModel.isLoading,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CommonAppBar(
            title: "Top Up Beneficiary",
            onTap: () {
              CustomNavigation().pop();
              topUpViewModel.clearForm();
            }),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hMargin),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infoTile("Beneficiary Name:", beneficiary.name,
                    AppColors.primaryColor),
                infoTile("Number:", beneficiary.number, AppColors.greyColor),
                infoTile("Remaining Monthly limit:",
                    "${beneficiary.remaining} AED", AppColors.blackColor),
                AmountGridView(topUpViewModelProvider: topUpViewModelProvider),
                PurposeDropDown(topUpViewModelProvider: topUpViewModelProvider),
                NotesFormField(topUpViewModelProvider: topUpViewModelProvider),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(hMargin),
          child: CustomButton(
            isEnable: topUpViewModel.isBtnEnable,
            bgColor: AppColors.primaryColor,
            onPressed: () async {
              await topUpViewModel.validatePayment(beneficiary);
            },
            title: "Proceed",
          ),
        ),
      ),
    );
  }

  Widget infoTile(String title, String info, Color infoColor) {
    return Row(
      children: [
        heading(title),
        const Spacer(),
        Text(
          info,
          style:
              PoppinsStyles.regular.copyWith(fontSize: 14.sp, color: infoColor),
        )
      ],
    );
  }

  Widget heading(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Text(
        title,
        style: PoppinsStyles.semiBold.copyWith(fontSize: 14.sp),
      ),
    );
  }
}

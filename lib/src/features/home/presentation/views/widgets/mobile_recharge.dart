import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/core/constants/globals.dart';
import 'package:technical_assessment_flutter/src/core/enums/user_status.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/presentation/viewmodels/beneficiary_viewmodel.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/presentation/views/beneficiary_list/beneficiary_list_view.dart';
import 'package:technical_assessment_flutter/src/features/auth/domain/models/user_model.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/viewmodels/top_up_viewmodel.dart';

class MobileRechargeView extends ConsumerStatefulWidget {
  final ChangeNotifierProvider<TopUpViewModel> topUpViewModelProvider;
  final ChangeNotifierProvider<BeneficiaryViewModel>
      beneficiaryViewModelProvider;

  const MobileRechargeView(
      {super.key,
      required this.topUpViewModelProvider,
      required this.beneficiaryViewModelProvider});

  @override
  ConsumerState<MobileRechargeView> createState() => _MobileRechargeViewState();
}

class _MobileRechargeViewState extends ConsumerState<MobileRechargeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(widget.beneficiaryViewModelProvider)
          .getBeneficiaries(ref.read(userModelProvider).id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userModelProvider);
    return Column(
      children: [
        BeneficiaryListView(
            topUpViewModelProvider: widget.topUpViewModelProvider,
            beneficiaryViewModelProvider: widget.beneficiaryViewModelProvider),
        Expanded(child: infoWidget(user)),
      ],
    );
  }

  Widget infoWidget(UserModel user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hMargin),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            remainingMonthlyLimit(user),
            20.verticalSpace,
            Text("Note :",
                style: PoppinsStyles.medium.copyWith(fontSize: 18.sp)),
            20.verticalSpace,
            infoPointsWidget(user.status == UserStatus.verified
                ? "You are verified!"
                : "You are not verified yet!"),
            10.verticalSpace,
            infoPointsWidget(
                "You can send a maximum of ${user.status == UserStatus.verified ? '500' : '1000'} AED per month per beneficiary."),
            10.verticalSpace,
            infoPointsWidget(
                "You can  top up multiple beneficiaries but is limited to a total of AED 3,000 per month for all beneficiaries."),
            100.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget remainingMonthlyLimit(UserModel user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Remaining monthly limit : ",
          style: PoppinsStyles.medium.copyWith(
              fontSize: 14.sp, height: 1.3, color: AppColors.blackColor),
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.7),
              borderRadius: BorderRadius.all(Radius.circular(5.r))),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Text(
              "${user.remainingMonthlyLimit.toStringAsFixed(1)} AED",
              style: PoppinsStyles.bold
                  .copyWith(fontSize: 14.sp, color: AppColors.whiteColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget infoPointsWidget(String info) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "*",
          style: PoppinsStyles.medium.copyWith(
            fontSize: 22.sp,
            color: Colors.red,
          ),
        ),
        5.horizontalSpace,
        Expanded(
          child: Text(
            info,
            style: PoppinsStyles.regular.copyWith(fontSize: 14.sp, height: 1.2),
          ),
        ),
      ],
    );
  }
}

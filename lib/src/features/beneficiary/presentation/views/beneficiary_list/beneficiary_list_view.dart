import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/presentation/viewmodels/beneficiary_viewmodel.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/presentation/views/beneficiary_list/widgets/beneficiary_card.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/presentation/views/beneficiary_list/widgets/beneficiary_shimmer.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/presentation/views/beneficiary_list/widgets/delete_button.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/viewmodels/top_up_viewmodel.dart';

class BeneficiaryListView extends ConsumerWidget {
  final ChangeNotifierProvider<TopUpViewModel> topUpViewModelProvider;
  final ChangeNotifierProvider<BeneficiaryViewModel>
      beneficiaryViewModelProvider;

  const BeneficiaryListView(
      {super.key,
      required this.topUpViewModelProvider,
      required this.beneficiaryViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beneficiaryViewModel = ref.watch(beneficiaryViewModelProvider);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sp),
        child: beneficiaryViewModel.isLoading
            ? const BeneficiaryShimmer()
            : beneficiaryViewModel.beneficiaryList.isNotEmpty
                ? SingleChildScrollView(
                    /// we are using stack that's why we need clip behaviour to be none
                    clipBehavior: Clip.none,

                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          beneficiaryViewModel.beneficiaryList.length, (index) {
                        final beneficiary =
                            beneficiaryViewModel.beneficiaryList[index];
                        return Stack(
                          /// we are using stack that's why we need clip behaviour to be none
                          clipBehavior: Clip.none,
                          children: [
                            BeneficiaryCard(
                              beneficiary: beneficiary,
                              topUpViewModelProvider: topUpViewModelProvider,
                            ),
                            DeleteButton(
                              beneficiaryViewModelProvider:
                                  beneficiaryViewModelProvider,
                              beneficiary: beneficiary,
                            ),
                          ],
                        );
                      }),
                    ),
                  )
                : Center(
                    child: Text(
                      "No beneficiary found",
                      style: PoppinsStyles.semiBold,
                    ),
                  ));
  }
}

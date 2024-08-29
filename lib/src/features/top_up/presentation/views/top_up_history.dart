import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_assessment_flutter/src/core/constants/colors.dart';
import 'package:technical_assessment_flutter/src/core/constants/fonts.dart';
import 'package:technical_assessment_flutter/src/core/constants/globals.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/top_up/domain/model/top_up.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/viewmodels/top_up_viewmodel.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/views/widgets/history_shimmer.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  final ChangeNotifierProvider<TopUpViewModel> topUpViewModelProvider;

  final List<BeneficiaryModel> beneficiaryList;

  const HistoryScreen(
      {required this.topUpViewModelProvider,
      required this.beneficiaryList,
      super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  @override
  void initState() {
    final topUpViewModel = ref.read(widget.topUpViewModelProvider);
    final userID = ref.read(userModelProvider).id;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      topUpViewModel.getTransactionHistory(userID);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topUpViewModel = ref.watch(widget.topUpViewModelProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hMargin),
        child: topUpViewModel.isLoading // Show shimmer if loading
            ? const HistoryShimmer()
            : topUpViewModel.transactionHistory.isNotEmpty
                ? Column(
                    children: List.generate(
                        topUpViewModel.transactionHistory.length, (index) {
                      final transaction =
                          topUpViewModel.transactionHistory[index];

                      return _buildHistoryItem(
                          transaction.beneficiary!, transaction);
                    }),
                  )
                : Center(
                    child: Text(
                      "No transaction history found",
                      style: PoppinsStyles.semiBold,
                    ),
                  ),
      ),
    );
  }

  Widget _buildHistoryItem(
      BeneficiaryModel beneficiary, Transaction transaction) {
    return Card(
      color: AppColors.offWhite,
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Beneficiary: ${beneficiary.name}',
              style: PoppinsStyles.medium.copyWith(
                fontSize: 16.sp,
                color: AppColors.primaryColor,
              ),
            ),
            10.verticalSpace,
            _buildRow('Number:', beneficiary.number),
            _buildRow('Purpose:', transaction.purpose),
            _buildRow('Transaction Amount:',
                '${transaction.amount.toStringAsFixed(2)} AED'),
            _buildRow('Date:', transaction.createdAt.toString().split(' ')[0]),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: PoppinsStyles.regular.copyWith(
              fontSize: 14.sp,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: PoppinsStyles.regular.copyWith(
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

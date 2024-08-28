import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_navigation.dart';
import 'package:technical_assessment_flutter/src/core/commons/success_dialog.dart';
import 'package:technical_assessment_flutter/src/core/constants/globals.dart';
import 'package:technical_assessment_flutter/src/core/constants/images.dart';
import 'package:technical_assessment_flutter/src/core/enums/snackbar_status.dart';
import 'package:technical_assessment_flutter/src/core/utilities/dialog_box.dart';
import 'package:technical_assessment_flutter/src/core/utilities/snack_bar.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/top_up/data/repositories/top_up_repository_impl.dart';
import 'package:technical_assessment_flutter/src/features/top_up/domain/model/top_up.dart';
import 'package:technical_assessment_flutter/src/features/top_up/domain/repositories/top_up_repository.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/views/widgets/invoice.dart';

class TopUpViewModel extends ChangeNotifier {
  final TopUpRepository _topUpRepository = TopUpRepositoryImpl();

  List<Transaction> transactionHistory = [];
  bool _isLoading = false;

  bool _isBtnEnable = false;

  bool get isLoading => _isLoading;

  bool get isBtnEnable => _isBtnEnable;
  final double serviceCharge = 1.0;

  final List<double> topUpAmounts = [5, 10, 20, 30, 50, 75, 100];
  final List<String> purposes = [
    'Gift',
    'Bill',
    'Package renewal',
    'Family',
    'Other'
  ];

  String? selectedPurpose;
  double? selectedAmount;
  TextEditingController notesController = TextEditingController();

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }



  Future<void> getTransactionHistory(String userId) async {
    try {
      setLoading(true);
      await Future.delayed(const Duration(milliseconds: 1000));
      transactionHistory = await _topUpRepository.getTransactionHistory(userId);
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }

  void _setEnableBtn() {
    _isBtnEnable = selectedAmount != null && selectedPurpose != null;
    notifyListeners();
  }

  void selectPurpose(String value) {
    selectedPurpose = value;
    _setEnableBtn();
    notifyListeners();
  }

  void selectTopUpAmount(double value) {
    selectedAmount = value;
    _setEnableBtn();
    notifyListeners();
  }

  Future<void> validatePayment(BeneficiaryModel beneficiary, WidgetRef ref) async {
    try {
      // Show Invoice dialog and proceed based on user's response
      bool? willProceed = await DialogBoxUtils.show(Invoice(
        amount: selectedAmount!,
        serviceCharge: serviceCharge,
      ));

      if (willProceed ?? false) {
        final totalAmount = selectedAmount! + serviceCharge;
        final user = ref.read(userModelProvider);

        if (user.availableBalance < totalAmount) {
          throw "Your balance is not enough to top up.";
        } else if (user.remainingMonthlyLimit < totalAmount) {
          throw "Your remaining monthly limit is less than AED ${totalAmount.toStringAsFixed(2)}.";
        } else if (beneficiary.remaining < totalAmount) {
          throw "Beneficiary's remaining limit for top-up is less than AED ${totalAmount.toStringAsFixed(2)}.";
        }

        await proceedPayment(totalAmount, beneficiary,ref);
      }
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error, seconds: 4);
    }
  }

  Future<void> proceedPayment(
      double totalAmount, BeneficiaryModel beneficiary, WidgetRef ref) async {
    try {
      final user=ref.read(userModelProvider);
      setLoading(true);
      final body = {
        "user_id": user.id,
        "beneficiary_id": beneficiary.id,
        "amount": totalAmount,
        "purpose": selectedPurpose!,
        "note": notesController.text
      };
      await _topUpRepository.topUp(body: body);

      /// When transaction done successfully update local variables
      /// I am not calling beneficiary and user api to fetch data updated data
      /// I know which local variable should change that's there is no need for api call
      /// if there is an error below code will not execute because of try catch
      ///  So local variable will not change in that case

      ref.read(userModelProvider.notifier).updateBalance(user.availableBalance-totalAmount);
      ref.read(userModelProvider.notifier).updateMonthlyLimit(user.remainingMonthlyLimit-totalAmount);

      beneficiary.remaining = beneficiary.remaining - totalAmount;

      clearForm();
      CustomNavigation().pop();
      await Future.delayed(const Duration(milliseconds: 500));

      /// show success dialog
      DialogBoxUtils.show(
        SuccessDialog(
          text:
              "Your payment of AED ${totalAmount.toStringAsFixed(2)} to ${beneficiary.name} has been successfully processed.",
          heading: "Payment Successful",
          img: AppImages.successIcon,
        ),
      );
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  clearForm() {
    selectedAmount = null;
    selectedPurpose = null;
    notesController.clear();
    _isBtnEnable = false;
  }
}

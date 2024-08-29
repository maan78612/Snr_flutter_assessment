import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_navigation.dart';
import 'package:technical_assessment_flutter/src/core/commons/success_dialog.dart';
import 'package:technical_assessment_flutter/src/core/constants/globals.dart';
import 'package:technical_assessment_flutter/src/core/constants/images.dart';
import 'package:technical_assessment_flutter/src/core/enums/snackbar_status.dart';
import 'package:technical_assessment_flutter/src/core/utilities/dialog_box.dart';
import 'package:technical_assessment_flutter/src/core/utilities/snack_bar.dart';
import 'package:technical_assessment_flutter/src/features/auth/domain/models/user_model.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/top_up/data/repositories/top_up_repository_impl.dart';
import 'package:technical_assessment_flutter/src/features/top_up/domain/model/top_up.dart';
import 'package:technical_assessment_flutter/src/features/top_up/domain/repositories/top_up_repository.dart';
import 'package:technical_assessment_flutter/src/features/top_up/presentation/views/widgets/invoice.dart';

class TopUpViewModel extends ChangeNotifier {
  // Repository for top-up-related data operations
  final TopUpRepository _topUpRepository = TopUpRepositoryImpl();

  // Transaction history for the user
  List<Transaction> transactionHistory = [];

  // Indicates if a process is currently loading
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Indicates if the top-up button should be enabled
  bool _isBtnEnable = false;

  bool get isBtnEnable => _isBtnEnable;

  // Service charge for top-up
  final double serviceCharge = 1.0;

  // Predefined top-up amounts
  final List<double> topUpAmounts = [5, 10, 20, 30, 50, 75, 100];

  // Predefined purposes for top-up
  final List<String> purposes = [
    'Gift',
    'Bill',
    'Package renewal',
    'Family',
    'Other'
  ];

  // Selected purpose for the top-up
  String? selectedPurpose;

  // Selected top-up amount
  double? selectedAmount;

  // Controller for notes input
  TextEditingController notesController = TextEditingController();

  /// Sets the loading state and notifies listeners.
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Fetches the transaction history for a given user.
  Future<void> getTransactionHistory(String userId) async {
    try {
      setLoading(true);
      transactionHistory = await _topUpRepository.getTransactionHistory(userId);
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }

  /// Sets the enabling state of the top-up button based on selected amount and purpose.
  void _setEnableBtn() {
    _isBtnEnable = selectedAmount != null && selectedPurpose != null;
    notifyListeners();
  }

  /// Selects a purpose for the top-up and updates the button state.
  void selectPurpose(String value) {
    selectedPurpose = value;
    _setEnableBtn();
  }

  /// Selects a top-up amount and updates the button state.
  void selectTopUpAmount(double value) {
    selectedAmount = value;
    _setEnableBtn();
  }

  /// Validates payment by checking balance and limits, then proceeds with the payment if valid.
  Future<void> validatePayment(
      BeneficiaryModel beneficiary, WidgetRef ref) async {
    try {
      /// Show Invoice dialog and proceed based on user's response
      bool? willProceed = await DialogBoxUtils.show(
        Invoice(
          amount: selectedAmount!,
          serviceCharge: serviceCharge,
        ),
      );

      if (willProceed ?? false) {
        final totalAmount = selectedAmount! + serviceCharge;
        final user = ref.read(userModelProvider);

        // Check if the user has enough balance
        if (user.availableBalance < totalAmount) {
          throw "Your balance is not enough to top up.";
        }

        // Check if the user's remaining monthly limit is sufficient
        if (user.remainingMonthlyLimit < totalAmount) {
          throw "Your remaining monthly limit is less than AED ${totalAmount.toStringAsFixed(2)}.";
        }

        // Check if the beneficiary's remaining limit is sufficient
        if (beneficiary.remaining < totalAmount) {
          throw "Beneficiary's remaining limit for top-up is less than AED ${totalAmount.toStringAsFixed(2)}.";
        }

        // Proceed with the payment if all checks pass
        await proceedPayment(totalAmount, beneficiary, ref, user);
      }
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error, seconds: 4);
    }
  }

  /// Proceeds with the payment and updates relevant data.
  Future<void> proceedPayment(double totalAmount, BeneficiaryModel beneficiary,
      WidgetRef ref, UserModel user) async {
    try {
      setLoading(true);

      final body = {
        "user_id": user.id,
        "beneficiary_id": beneficiary.id,
        "amount": totalAmount,
        "purpose": selectedPurpose!,
        "note": notesController.text
      };

      await _topUpRepository.topUp(body: body);

      /*
          Update local variables without fetching updated data from API
          if there is an error below code will not execute because of try catch
          So local variable will not change in that case
      */

      ref.read(userModelProvider.notifier).updateBalance(totalAmount);
      ref.read(userModelProvider.notifier).updateMonthlyLimit(totalAmount);

      beneficiary.remaining -= totalAmount;

      // Clear the form and pop the navigation stack
      clearForm();
      CustomNavigation().pop();

      // Show success dialog after a short delay
      await Future.delayed(const Duration(milliseconds: 500));
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

  /// Clears the top-up form.
  void clearForm() {
    selectedAmount = null;
    selectedPurpose = null;
    notesController.clear();
    _isBtnEnable = false;
    notifyListeners();
  }
}

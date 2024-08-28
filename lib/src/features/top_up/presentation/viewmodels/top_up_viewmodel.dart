import 'package:flutter/material.dart';
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

  Future<void> initMethod() async {
    await getTransactionHistory();
  }

  Future<void> getTransactionHistory() async {
    try {
      setLoading(true);
      await Future.delayed(const Duration(milliseconds: 1000));
      transactionHistory = await _topUpRepository.getTransactionHistory();
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

  Future<void> validatePayment(BeneficiaryModel beneficiary) async {
    try {
      Transaction transaction = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: 1,
        beneficiaryId: beneficiary.id,
        amount: selectedAmount!,
        createdAt: DateTime.now(),
        purpose: selectedPurpose!,
        note: notesController.text,
      );

      // Show Invoice dialog and proceed based on user's response
      bool? willProceed = await DialogBoxUtils.show(Invoice(
        transaction: transaction,
        serviceCharge: serviceCharge,
      ));

      if (willProceed ?? false) {
        transaction.amount = transaction.amount + serviceCharge;

        if (user!.availableBalance < transaction.amount) {
          throw "Your balance is not enough to top up.";
        } else if (user!.remainingMonthlyLimit < transaction.amount) {
          throw "Your remaining monthly limit is less than AED ${transaction.amount.toStringAsFixed(2)}.";
        } else if (beneficiary.remaining < transaction.amount) {
          throw "Beneficiary's remaining limit for top-up is less than AED ${transaction.amount.toStringAsFixed(2)}.";
        }

        await proceedPayment(transaction, beneficiary);
      }
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error, seconds: 4);
    }
  }

  Future<void> proceedPayment(
      Transaction transaction, BeneficiaryModel beneficiary) async {
    try {
      setLoading(true);



      await Future.delayed(const Duration(milliseconds: 2000));
      print(transaction.toJson());
      clearForm();
      CustomNavigation().pop();
      await Future.delayed(const Duration(milliseconds: 500));

      DialogBoxUtils.show(
        SuccessDialog(
          text:
              "Your payment of AED ${transaction.amount.toStringAsFixed(2)} to ${beneficiary.name} has been successfully processed.",
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

/*   final body = {
        "name": nickNameCon.controller.text,
        "phoneNumber": "+971${numberCon.controller.text}",
        "limit": 500,
        "user_id": "user-123",
      };
      await _topUpRepository.topUp(body: body);

      await DialogBoxUtils.show(
        SuccessDialog(
          text: 'You added ${nickNameCon.controller.text} as a beneficiary',
          heading: 'Congratulations!',
          img: AppImages.successIcon,
        ),
      );*/

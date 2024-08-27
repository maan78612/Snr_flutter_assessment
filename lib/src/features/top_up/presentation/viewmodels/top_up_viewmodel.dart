import 'package:flutter/material.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_navigation.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_text_controller.dart';
import 'package:technical_assessment_flutter/src/core/commons/success_dialog.dart';
import 'package:technical_assessment_flutter/src/core/constants/images.dart';
import 'package:technical_assessment_flutter/src/core/enums/snackbar_status.dart';
import 'package:technical_assessment_flutter/src/core/utilities/dialog_box.dart';
import 'package:technical_assessment_flutter/src/core/utilities/snack_bar.dart';
import 'package:technical_assessment_flutter/src/features/top_up/data/repositories/top_up_repository_impl.dart';
import 'package:technical_assessment_flutter/src/features/top_up/domain/repositories/top_up_repository.dart';

class TopUpViewModel extends ChangeNotifier {
  final TopUpRepository _topUpRepository = TopUpRepositoryImpl();
  bool _isLoading = false;

  bool _isBtnEnable = false;

  bool get isLoading => _isLoading;

  bool get isBtnEnable => _isBtnEnable;

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
    await getBeneficiaries();
  }

  Future<void> getBeneficiaries() async {
    try {
      setLoading(true);
      await Future.delayed(const Duration(milliseconds: 1000));
      // beneficiaryList = await _topUpRepository.getTopUpHistory();
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

  Future<void> topUp() async {
    try {
      setLoading(true);
      await Future.delayed(const Duration(milliseconds: 2000));
      // final body = {
      //   "name": nickNameCon.controller.text,
      //   "phoneNumber": "+971${numberCon.controller.text}",
      //   "limit": 500,
      //   "user_id": "user-123",
      // };
      // await _topUpRepository.topUp(body: body);
      //
      // await DialogBoxUtils.show(
      //   SuccessDialog(
      //     text: 'You added ${nickNameCon.controller.text} as a beneficiary',
      //     heading: 'Congratulations!',
      //     img: AppImages.successIcon,
      //   ),
      // );

      CustomNavigation().pop();
      await Future.delayed(const Duration(milliseconds: 500));
      DialogBoxUtils.show(const SuccessDialog(
          text: "Your top up of 51 AED has been proceed successfully",
          heading: "Payment Successful",
          img: AppImages.successIcon));
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_navigation.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_text_controller.dart';
import 'package:technical_assessment_flutter/src/core/commons/success_dialog.dart';
import 'package:technical_assessment_flutter/src/core/constants/globals.dart';
import 'package:technical_assessment_flutter/src/core/constants/images.dart';
import 'package:technical_assessment_flutter/src/core/enums/snackbar_status.dart';
import 'package:technical_assessment_flutter/src/core/enums/user_status.dart';
import 'package:technical_assessment_flutter/src/core/utilities/dialog_box.dart';
import 'package:technical_assessment_flutter/src/core/utilities/snack_bar.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/data/repositories/beneficiary_repository_impl.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/repositories/beneficiary_repository.dart';
import 'package:technical_assessment_flutter/src/features/home/domain/models/user_model.dart';

class BeneficiaryViewModel extends ChangeNotifier {
  final BeneficiaryRepository _beneficiaryRepository =
      BeneficiaryRepositoryImpl();
  bool _isLoading = false;
  List<BeneficiaryModel> beneficiaryList = [];
  bool _isBtnEnable = false;

  CustomTextController nickNameCon = CustomTextController(
    controller: TextEditingController(),
    focusNode: FocusNode(),
  );
  CustomTextController numberCon = CustomTextController(
    controller: TextEditingController(),
    focusNode: FocusNode(),
  );

  bool get isLoading => _isLoading;

  bool get isBtnEnable => _isBtnEnable;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void onChange({
    required CustomTextController con,
    String? Function(String?)? validator,
    required String value,
  }) {
    if (validator != null) {
      con.error = validator(value);
    }
    _setEnableBtn();
  }

  void _setEnableBtn() {
    final isNameValid =
        nickNameCon.controller.text.isNotEmpty && nickNameCon.error == null;
    final isNumberValid =
        numberCon.controller.text.isNotEmpty && numberCon.error == null;

    _isBtnEnable = isNameValid && isNumberValid;
    notifyListeners();
  }

  void clearForm() {
    nickNameCon.controller.clear();
    nickNameCon.error = null;
    numberCon.controller.clear();
    numberCon.error = null;
    _isBtnEnable = false;
    notifyListeners();
  }

  Future<void> getBeneficiaries(String userId) async {
    try {
      setLoading(true);

      beneficiaryList = await _beneficiaryRepository.getBeneficiaries(userId);
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }

  Future<void> addBeneficiary(UserModel user) async {
    try {
      if (beneficiaryList.length >= 5) {
        throw "You have reached maximum limit of 5  for adding beneficiary";
      }
      setLoading(true);

      /// if user verified beneficiary limit is 500 , else 1000
      double initialMonthlyLimit =
          user.status == UserStatus.verified ? 500 : 1000;

      final body = {
        "name": nickNameCon.controller.text,
        "number": "+971${numberCon.controller.text}",
        "monthlyLimit": initialMonthlyLimit,
        "user_id": user.id,
      };
      final BeneficiaryModel beneficiary =
          await _beneficiaryRepository.addBeneficiary(body: body);
      beneficiaryList.add(beneficiary);

      await DialogBoxUtils.show(
        SuccessDialog(
          text: 'You added ${nickNameCon.controller.text} as a beneficiary',
          heading: 'Congratulations!',
          img: AppImages.successIcon,
        ),
      );
      clearForm();
      CustomNavigation().pop();
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error, seconds: 4);
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteBeneficiary(BeneficiaryModel beneficiary) async {
    try {
      setLoading(true);
      await _beneficiaryRepository.deleteBeneficiary(beneficiary.id);
      beneficiaryList.removeWhere((ben) => ben.id == beneficiary.id);

      await DialogBoxUtils.show(
        SuccessDialog(
          text: 'Beneficiary ${beneficiary.name} successfully deleted',
          heading: 'Beneficiary Deleted!',
          img: AppImages.successIcon,
        ),
      );
      clearForm();
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error, seconds: 4);
    } finally {
      setLoading(false);
    }
  }
}

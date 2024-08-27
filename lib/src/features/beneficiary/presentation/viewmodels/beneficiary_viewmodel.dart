import 'package:flutter/material.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_navigation.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_text_controller.dart';
import 'package:technical_assessment_flutter/src/core/commons/success_dialog.dart';
import 'package:technical_assessment_flutter/src/core/constants/images.dart';
import 'package:technical_assessment_flutter/src/core/enums/snackbar_status.dart';
import 'package:technical_assessment_flutter/src/core/utilities/dialog_box.dart';
import 'package:technical_assessment_flutter/src/core/utilities/snack_bar.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/data/repositories/beneficiary_repository_impl.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/repositories/beneficiary_repository.dart';

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

  Future<void> initMethod() async {
    await getBeneficiaries();
  }

  Future<void> getBeneficiaries() async {
    try {
      setLoading(true);
      await Future.delayed(const Duration(milliseconds: 1000));
      beneficiaryList = await _beneficiaryRepository.getBeneficiaries();
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    } finally {
      setLoading(false);
    }
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
    nickNameCon.error=null;
    numberCon.controller.clear();
    numberCon.error=null;
    _isBtnEnable = false;
    notifyListeners();
  }

  Future<void> addBeneficiary() async {
    try {
      setLoading(true);

      final body = {
        "name": nickNameCon.controller.text,
        "phoneNumber": "+971${numberCon.controller.text}",
        "limit": 500,
        "user_id": "user-123",
      };
      await _beneficiaryRepository.addBeneficiary(body: body);

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
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }
}

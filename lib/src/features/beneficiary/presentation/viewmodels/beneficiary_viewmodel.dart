import 'package:flutter/material.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_navigation.dart';
import 'package:technical_assessment_flutter/src/core/commons/custom_text_controller.dart';
import 'package:technical_assessment_flutter/src/core/commons/success_dialog.dart';
import 'package:technical_assessment_flutter/src/core/constants/images.dart';
import 'package:technical_assessment_flutter/src/core/enums/snackbar_status.dart';
import 'package:technical_assessment_flutter/src/core/enums/user_status.dart';
import 'package:technical_assessment_flutter/src/core/utilities/dialog_box.dart';
import 'package:technical_assessment_flutter/src/core/utilities/snack_bar.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/data/repositories/beneficiary_repository_impl.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/repositories/beneficiary_repository.dart';
import 'package:technical_assessment_flutter/src/features/auth/domain/models/user_model.dart';

class BeneficiaryViewModel extends ChangeNotifier {
  // Repository for beneficiary-related data operations
  final BeneficiaryRepository _beneficiaryRepository =
      BeneficiaryRepositoryImpl();

  // Indicates if a process is currently loading
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // List of beneficiaries
  List<BeneficiaryModel> beneficiaryList = [];

  // Indicates if the add beneficiary button should be enabled
  bool _isBtnEnable = false;

  bool get isBtnEnable => _isBtnEnable;

  // Controllers for nickname and number input fields
  CustomTextController nickNameCon = CustomTextController(
    controller: TextEditingController(),
    focusNode: FocusNode(),
  );

  CustomTextController numberCon = CustomTextController(
    controller: TextEditingController(),
    focusNode: FocusNode(),
  );

  /// Sets the loading state and notifies listeners.
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Handles input changes, performs validation, and updates the button state.
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

  /// Sets the enabling state of the button based on input validation.
  void _setEnableBtn() {
    final isNameValid =
        nickNameCon.controller.text.isNotEmpty && nickNameCon.error == null;
    final isNumberValid =
        numberCon.controller.text.isNotEmpty && numberCon.error == null;

    _isBtnEnable = isNameValid && isNumberValid;
    notifyListeners();
  }

  /// Clears the input fields and resets the button state.
  void clearForm() {
    nickNameCon.controller.clear();
    nickNameCon.error = null;
    numberCon.controller.clear();
    numberCon.error = null;
    _isBtnEnable = false;
    notifyListeners();
  }

  /// Fetches the list of beneficiaries for a given user.
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

  /// Adds a new beneficiary for the user, ensuring limits are respected.
  Future<void> addBeneficiary(UserModel user) async {
    try {
      // Check if the maximum limit of beneficiaries has been reached
      if (beneficiaryList.length >= 5) {
        throw "You have reached the maximum limit of 5 beneficiaries.";
      }

      setLoading(true);

      // Determine the initial monthly limit based on the user's verification status
      double initialMonthlyLimit =
          user.status == UserStatus.verified ? 500 : 1000;

      final body = {
        "name": nickNameCon.controller.text,
        "number": "+971${numberCon.controller.text}",
        "monthlyLimit": initialMonthlyLimit,
        "user_id": user.id,
      };

      // Add the new beneficiary and update the list
      final BeneficiaryModel beneficiary =
          await _beneficiaryRepository.addBeneficiary(body: body);
      beneficiaryList.insert(0, beneficiary);

      // Show success dialog
      await DialogBoxUtils.show(
        SuccessDialog(
          text: 'You added ${nickNameCon.controller.text} as a beneficiary.',
          heading: 'Congratulations!',
          img: AppImages.successIcon,
        ),
      );

      // Clear the form and navigate back
      clearForm();
      CustomNavigation().pop();
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error, seconds: 4);
    } finally {
      setLoading(false);
    }
  }

  /// Deletes a beneficiary and updates the list.
  Future<void> deleteBeneficiary(BeneficiaryModel beneficiary) async {
    try {
      setLoading(true);

      // Delete the beneficiary from the repository
      await _beneficiaryRepository.deleteBeneficiary(beneficiary.id);

      // Remove the beneficiary from the local list
      beneficiaryList.removeWhere((ben) => ben.id == beneficiary.id);

      // Show success dialog
      await DialogBoxUtils.show(
        SuccessDialog(
          text: 'Beneficiary ${beneficiary.name} successfully deleted.',
          heading: 'Beneficiary Deleted!',
          img: AppImages.successIcon,
        ),
      );

      // Clear the form
      clearForm();
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error, seconds: 4);
    } finally {
      setLoading(false);
    }
  }
}

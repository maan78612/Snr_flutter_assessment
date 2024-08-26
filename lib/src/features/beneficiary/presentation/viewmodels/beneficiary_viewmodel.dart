import 'package:flutter/material.dart';
import 'package:technical_assessment_flutter/src/core/enums/snackbar_status.dart';
import 'package:technical_assessment_flutter/src/core/utilities/snack_bar.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/data/repositories/beneficiary_repository_impl.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/repositories/beneficiary_repository.dart';

class BeneficiaryViewModel extends ChangeNotifier {
  final BeneficiaryRepository _beneficiaryRepository =
      BeneficiaryRepositoryImpl();
  bool _isLoading = false;
  List<BeneficiaryModel> beneficiaryList = [];

  bool get isLoading => _isLoading;

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
      notifyListeners();
      print("getBeneficiaries = ${beneficiaryList.length}");
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }
}

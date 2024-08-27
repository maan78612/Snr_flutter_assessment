import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';

abstract class BeneficiaryRepository {
  Future<List<BeneficiaryModel>> getBeneficiaries();
  Future<void> addBeneficiary({required Map<String, dynamic> body});
}

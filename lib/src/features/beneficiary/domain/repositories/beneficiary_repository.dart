import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';

abstract class BeneficiaryRepository {
  Future<List<BeneficiaryModel>> getBeneficiaries(String userId);
  Future<BeneficiaryModel> addBeneficiary({required Map<String, dynamic> body});
  Future<void> deleteBeneficiary(String beneficiaryId);
}

import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';

abstract class TopUpRepository {
  Future<List<BeneficiaryModel>> getTopUpHistory();
  Future<void> topUp({required Map<String, dynamic> body});
}

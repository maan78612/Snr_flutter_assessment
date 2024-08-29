import 'package:technical_assessment_flutter/src/core/constants/api_urls.dart';
import 'package:technical_assessment_flutter/src/core/services/network/api_data_source.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/repositories/beneficiary_repository.dart';

class BeneficiaryRepositoryImpl implements BeneficiaryRepository {
  @override
  Future<List<BeneficiaryModel>> getBeneficiaries(String userId) async {
    try {
      final response =
          await NetworkApi.instance.get(url: "${ApiUrls.beneficiary}/$userId");

      return List<BeneficiaryModel>.from(
          response.map((x) => BeneficiaryModel.fromJson(x))).reversed.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BeneficiaryModel> addBeneficiary(
      {required Map<String, dynamic> body}) async {
    try {
      final response =
          await NetworkApi.instance.post(url: ApiUrls.beneficiary, body: body);
      return BeneficiaryModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteBeneficiary(String beneficiaryId) async {
    try {
      final response = await NetworkApi.instance
          .delete(url: "${ApiUrls.beneficiary}/$beneficiaryId");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:technical_assessment_flutter/src/core/constants/api_urls.dart';
import 'package:technical_assessment_flutter/src/core/services/network/api_data_source.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/repositories/beneficiary_repository.dart';

class BeneficiaryRepositoryImpl implements BeneficiaryRepository {
  @override
  Future<List<BeneficiaryModel>> getBeneficiaries() async {
 /*   try {
      final response =
      await NetworkApi.instance.get(url: ApiUrls.beneficiary, body: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }*/

    try {
      return [
        BeneficiaryModel(
          id: 1,
          name: "John Doe",
          number: "1234567890",
          userId: 1,
          monthlyLimit: 500.0,
          remaining: 300.0,
          createdAt: DateTime.now(),
        ),
        BeneficiaryModel(
          id: 2,
          name: "Jane Smith",
          number: "9876543210",
          userId: 1,
          monthlyLimit: 500.0,
          remaining: 450.0,
          createdAt: DateTime.now(),
        ),
        BeneficiaryModel(
          id: 3,
          name: "Alice Johnson",
          number: "5556667778",
          userId: 1,
          monthlyLimit: 500.0,
          remaining: 10.0,
          createdAt: DateTime.now(),
        ),
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addBeneficiary({required Map<String, dynamic> body}) async {
    try {
      final response =
          await NetworkApi.instance.post(url: ApiUrls.beneficiary, body: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteBeneficiary() async {
    try {
      final response =
          await NetworkApi.instance.delete(url: ApiUrls.beneficiary);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

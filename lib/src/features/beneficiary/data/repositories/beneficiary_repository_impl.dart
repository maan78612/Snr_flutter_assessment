import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/beneficiary/domain/repositories/beneficiary_repository.dart';

class BeneficiaryRepositoryImpl implements BeneficiaryRepository {
  @override

  Future<List<BeneficiaryModel>> getBeneficiaries() async {
    try {
      // await NetworkApi.instance.get(url: ApiUrls.getScore);

      return [
        BeneficiaryModel(
          id: 1,
          name: "John Doe",
          number: "1234567890",
          userId: "token123",
          monthlyLimit: 500.0,
          remaining: 300.0,
          createdAt: DateTime.now(),
        ),
        BeneficiaryModel(
          id: 2,
          name: "Jane Smith",
          number: "9876543210",
          userId: "token456",
          monthlyLimit: 500.0,
          remaining: 450.0,
          createdAt: DateTime.now(),
        ),
        BeneficiaryModel(
          id: 3,
          name: "Alice Johnson",
          number: "5556667778",
          userId: "token789",
          monthlyLimit: 500.0,
          remaining: 250.0,
          createdAt: DateTime.now(),
        ),
      ];
    } catch (e) {
      rethrow;
    }
  }
}

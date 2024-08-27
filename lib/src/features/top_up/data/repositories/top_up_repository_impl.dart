import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/top_up/domain/repositories/top_up_repository.dart';

class TopUpRepositoryImpl implements TopUpRepository {
  @override
  Future<List<BeneficiaryModel>> getTopUpHistory() async {
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

  @override
  Future<void> topUp({required Map<String, dynamic> body}) async {
    print(body);
  }
}

import 'package:technical_assessment_flutter/src/features/beneficiary/domain/model/beneficiary.dart';
import 'package:technical_assessment_flutter/src/features/top_up/domain/model/top_up.dart';
import 'package:technical_assessment_flutter/src/features/top_up/domain/repositories/top_up_repository.dart';

class TopUpRepositoryImpl implements TopUpRepository {
  @override
  Future<List<Transaction>> getTransactionHistory() async {
    try {
      return [
        Transaction(
          id: "tx_001",
          userId: 1,
          beneficiaryId: 1,
          amount: 100.0,
          createdAt: DateTime.now(),
          purpose: "Mobile Recharge",
          note: "Monthly top-up",
        ),
        Transaction(
          id: "tx_002",
          userId: 1,
          beneficiaryId: 2,
          amount: 50.0,
          createdAt: DateTime.now(),
          purpose: "Family",
          note: "Electricity payment",
        )
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

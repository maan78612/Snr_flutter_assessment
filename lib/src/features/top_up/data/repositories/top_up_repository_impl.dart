import 'package:technical_assessment_flutter/src/core/constants/api_urls.dart';
import 'package:technical_assessment_flutter/src/core/services/network/api_data_source.dart';
import 'package:technical_assessment_flutter/src/features/top_up/domain/model/top_up.dart';
import 'package:technical_assessment_flutter/src/features/top_up/domain/repositories/top_up_repository.dart';

class TopUpRepositoryImpl implements TopUpRepository {
  @override
  Future<List<Transaction>> getTransactionHistory() async {

    /*  try {
      final response =
      await NetworkApi.instance.get(url: ApiUrls.topUp);
      return response;
    } catch (e) {
      rethrow;
    }*/

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
    try {
      final response =
      await NetworkApi.instance.post(url: ApiUrls.topUp, body: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

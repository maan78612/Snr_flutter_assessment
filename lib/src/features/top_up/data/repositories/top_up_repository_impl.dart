import 'package:technical_assessment_flutter/src/core/constants/api_urls.dart';
import 'package:technical_assessment_flutter/src/core/services/network/api_data_source.dart';
import 'package:technical_assessment_flutter/src/features/top_up/domain/model/top_up.dart';
import 'package:technical_assessment_flutter/src/features/top_up/domain/repositories/top_up_repository.dart';

class TopUpRepositoryImpl implements TopUpRepository {
  @override
  Future<List<Transaction>> getTransactionHistory(String userId) async {
    try {
      final response = await NetworkApi.instance
          .get(url: "${ApiUrls.transactionHistory}$userId");

      return List<Transaction>.from(
        response
            .map((x) => Transaction.fromJson(x))
            .where((transaction) => transaction.beneficiary != null),
      ).reversed.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> topUp({required Map<String, dynamic> body}) async {
    try {
      final response =
          await NetworkApi.instance.post(url: ApiUrls.transactions, body: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

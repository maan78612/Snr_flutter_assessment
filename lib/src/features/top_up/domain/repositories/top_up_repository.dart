import 'package:technical_assessment_flutter/src/features/top_up/domain/model/top_up.dart';

abstract class TopUpRepository {
  Future<List<Transaction>> getTransactionHistory();

  Future<void> topUp({required Map<String, dynamic> body});
}

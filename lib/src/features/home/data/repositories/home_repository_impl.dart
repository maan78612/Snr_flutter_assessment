import 'package:technical_assessment_flutter/src/core/constants/api_urls.dart';
import 'package:technical_assessment_flutter/src/core/services/network/api_data_source.dart';
import 'package:technical_assessment_flutter/src/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<void> resetBalances({required Map<String, dynamic> body}) async {
    try {
      final response =
          await NetworkApi.instance.post(url: ApiUrls.resetMonth, body: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

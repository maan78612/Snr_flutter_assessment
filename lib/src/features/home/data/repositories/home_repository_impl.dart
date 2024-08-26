import 'package:technical_assessment_flutter/src/core/constants/api_urls.dart';
import 'package:technical_assessment_flutter/src/core/services/network/api_data_source.dart';
import 'package:technical_assessment_flutter/src/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<void> getBeneficiaries() async {
    try {
      await NetworkApi.instance.get(url: ApiUrls.getScore);
    } catch (e) {
      rethrow;
    }
  }
}

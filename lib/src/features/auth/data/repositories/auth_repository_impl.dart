import 'package:technical_assessment_flutter/src/core/constants/api_urls.dart';
import 'package:technical_assessment_flutter/src/core/services/network/api_data_source.dart';
import 'package:technical_assessment_flutter/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:technical_assessment_flutter/src/features/auth/domain/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserModel> login({required Map<String, dynamic> body}) async {
    try {
      final response =
          await NetworkApi.instance.post(url: ApiUrls.login, body: body);
      return UserModel.fromJson(response["user"]);
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:technical_assessment_flutter/src/features/home/domain/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login({required Map<String, dynamic> body});
}

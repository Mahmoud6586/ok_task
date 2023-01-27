import 'dart:convert';

import 'package:ok_task/core/error/failures.dart';
import 'package:ok_task/features/login_feature/domain/entities/login_entity.dart';
import 'package:http/http.dart' as http;

abstract class LoginRemoteDatasource {
  Future<String> loginUser(LoginEntity loginEntity);
}

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  @override
  Future<String> loginUser(LoginEntity loginEntity) async {
    final response = await http.post(
        Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
        body: {'email': loginEntity.email, 'password': loginEntity.password});
    final responseData = json.decode(response.body);
    if (responseData['access_token'] != null) {
      final String accessToken = responseData['access_token'];
      return accessToken;
    } else if (responseData['statusCode'] == 401) {
      return 'Unauthorized';
    } else {
      throw ServerFailure();
    }
  }
}

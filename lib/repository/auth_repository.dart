import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter/exceptions/api_exception.dart';
import 'package:test_flutter/exceptions/result.dart';
import 'package:test_flutter/widget/auth/AuthWidget.dart';
import '../../dto/Token.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  const AuthRepository({required this.dio});

  final Dio dio;

  Future<Result<String, APIException>> authenticate(
      String userName, String password) async {
    Response response;
    try {
      response = await dio.post("/auth/authenticate",
          data: {'login': userName, 'password': password});
    } on DioException catch (e) {
      logger.i(e.response.toString());
      if (e.response?.statusCode == 401) {
        return Failure(
            APIException(401, 'Не правильные имя пользователя/пароль'));
      } else {
        var errorText = e.response?.headers['x-error'];
        return Failure(APIException(500, 'Ошибка сервера: $errorText'));
      }
    }
    var tokenEntity = Token.fromJson(response.data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', tokenEntity.token);
    return Success(tokenEntity.token);
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> is_auth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth_token');
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
}

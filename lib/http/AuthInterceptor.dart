import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Получаем токен авторизации из SharedPreferences или из другого места хранения
    String? authToken = await getAuthToken();
    // Добавляем заголовок авторизации
    if (authToken != null) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    // Передаем обработку запроса следующему Interceptor или отправляем его на сервер
    handler.next(options);
  }

  Future<String?> getAuthToken() async {
    var instance = await SharedPreferences.getInstance();
    // Ваш код получения токена авторизации (из SharedPreferences или другого места)
    // Верните токен авторизации
    var token = instance.getString("auth_token");
    return token;
  }
}

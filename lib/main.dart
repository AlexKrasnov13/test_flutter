import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:test_flutter/app.dart';
import 'package:test_flutter/http/AuthInterceptor.dart';
import 'package:test_flutter/repository/auth_repository.dart';
import 'package:test_flutter/repository/currency_repository.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  var baseUrl = dotenv.env['SERVER_BASE_URL'] as String;
  // const bool isProduction = bool.fromEnvironment('dart.vm.product');
  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    // Дополнительные настройки Dio, если требуется
  ));
  // интерсептр авторизации
  dio.interceptors.add(AuthInterceptor());

  GetIt.I.registerSingleton<AuthRepository>(AuthRepository(dio: dio));
  GetIt.I.registerSingleton<CurrencyRepository>(CurrencyRepository(dio: dio));
  runApp(const MyApp());
}



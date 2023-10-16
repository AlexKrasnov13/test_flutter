import 'package:test_flutter/dto/Currency.dart';
import 'package:test_flutter/exceptions/api_exception.dart';
import 'package:test_flutter/exceptions/result.dart';
import 'package:dio/dio.dart';

class CurrencyRepository {
  const CurrencyRepository({required this.dio});

  final Dio dio;

  Future<Result<List<Currency>, APIException>> getCurrencies() async {
    List<Currency> result;
    try {
      Response response = await dio.get('/currency');
      List<dynamic> responseData = response.data;
      result = responseData.map((data) => Currency.fromJson(data)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Failure(APIException(401, 'Доступ запрещен'));
      } else {
        var errorText = e.response?.headers['x-error'];
        return Failure(APIException(500, 'Ошибка сервера: $errorText'));
      }
    }
    return Success(result);
  }
}

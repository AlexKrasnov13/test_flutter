class APIException implements Exception {
  late String _message;
  late int _statusCode;

  APIException(int statusCode, String message) {
    _message = message;
    _statusCode = statusCode;
  }

  String getMessage() {
    return _message;
  }

  int getCode() {
    return _statusCode;
  }
}

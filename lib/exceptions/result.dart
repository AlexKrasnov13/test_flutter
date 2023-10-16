sealed class Result<S, APIException> {
  const Result();
}

final class Success<S, APIException> extends Result<S, APIException> {
  const Success(this.value);

  final S value;
}

final class Failure<S, APIException> extends Result<S, APIException> {
  const Failure(this.exception);

  final APIException exception;
}

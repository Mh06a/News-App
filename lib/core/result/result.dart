

import 'package:news_app/core/error/failure.dart';

sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is FailureResult<T>;

  T? get data {
    if (this case Success<T>(data: final data)) {
      return data;
    }

    return null;
  }

  Failure? get failure {
    if (this case FailureResult<T>(failure: final failure)) {
      return failure;
    }

    return null;
  }
}

final class Success<T> extends Result<T> {
  @override
  final T data;

  const Success(this.data);
}

final class FailureResult<T> extends Result<T> {
  @override
  final Failure failure;

  const FailureResult(this.failure);
}
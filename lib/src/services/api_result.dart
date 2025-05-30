/// Represents the result of an API call.
sealed class ApiResult<T> {
  const ApiResult();

  /// Creates an [ApiResult] representing a successful API call.
  ///
  /// The [data] parameter is the data returned by the API.
  factory ApiResult.success(T data) = ApiSuccess<T>;

  /// Creates an [ApiResult] representing a failed API call.
  ///
  /// The [error] parameter is the error that occurred during the API call.
  /// The [stackTrace] parameter is the stack trace of the error.
  factory ApiResult.failure({
    required Object error,
    StackTrace? stackTrace,
  }) = ApiFailure<T>;
}

/// Represents a successful API result.
class ApiSuccess<T> extends ApiResult<T> {
  const ApiSuccess(this.data);

  /// The data returned by the API.
  final T data;
}

/// Represents a failed API result.
class ApiFailure<T> extends ApiResult<T> {
  const ApiFailure({
    required this.error,
    this.stackTrace,
  });

  /// The error that occurred during the API call.
  final Object error;

  /// The stack trace of the error.
  final StackTrace? stackTrace;
}

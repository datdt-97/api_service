interface class APIError extends Error {
  int? get statusCode => null;

  String? get errorDescription => null;
}

final class APIInvalidResponseError implements APIError {
  @override
  int? get statusCode => null;

  @override
  String get errorDescription => 'Invalid server response';

  @override
  StackTrace? get stackTrace => null;
}

final class APIUnknownError implements APIError {
  APIUnknownError(int? statusCode) {
    _statusCode = statusCode;
  }

  int? _statusCode;

  @override
  int? get statusCode => _statusCode;

  @override
  String get errorDescription => 'Unknown API error';

  @override
  StackTrace? get stackTrace => null;
}

abstract interface class APIException implements Exception {
  int? get statusCode;

  String get errorDescription;
}

final class APIInvalidResponseException implements APIException {
  @override
  int? get statusCode => null;

  @override
  String get errorDescription => 'Invalid server response';
}

final class APIUnknownException implements APIException {
  final int? code;

  const APIUnknownException({
    this.code,
  });

  @override
  int? get statusCode => code;

  @override
  String get errorDescription => 'Unknown API error';
}

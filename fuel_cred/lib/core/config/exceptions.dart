/// App-wide exception hierarchy for consistent error handling

abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;
  final StackTrace? stackTrace;

  AppException({
    required this.message,
    this.code,
    this.originalException,
    this.stackTrace,
  });

  @override
  String toString() => message;
}

/// Network-related exceptions
class NetworkException extends AppException {
  NetworkException({
    required String message,
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Server-side exceptions (5xx errors)
class ServerException extends AppException {
  final int? statusCode;

  ServerException({
    required String message,
    this.statusCode,
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Client-side exceptions (4xx errors)
class ClientException extends AppException {
  final int? statusCode;

  ClientException({
    required String message,
    this.statusCode,
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Authentication-related exceptions
class AuthException extends AppException {
  AuthException({
    required String message,
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Validation-related exceptions
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  ValidationException({
    required String message,
    this.fieldErrors,
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Cache-related exceptions
class CacheException extends AppException {
  CacheException({
    required String message,
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Payment-related exceptions
class PaymentException extends AppException {
  final String? transactionId;

  PaymentException({
    required String message,
    this.transactionId,
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Geolocation-related exceptions
class LocationException extends AppException {
  LocationException({
    required String message,
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Security-related exceptions
class SecurityException extends AppException {
  SecurityException({
    required String message,
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Generic/unknown exceptions
class UnknownException extends AppException {
  UnknownException({
    required String message,
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

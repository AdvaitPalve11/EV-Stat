/// App-wide exception hierarchy for consistent error handling
library;

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
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });
}

/// Server-side exceptions (5xx errors)
class ServerException extends AppException {
  final int? statusCode;

  ServerException({
    required super.message,
    this.statusCode,
    super.code,
    super.originalException,
    super.stackTrace,
  });
}

/// Client-side exceptions (4xx errors)
class ClientException extends AppException {
  final int? statusCode;

  ClientException({
    required super.message,
    this.statusCode,
    super.code,
    super.originalException,
    super.stackTrace,
  });
}

/// Authentication-related exceptions
class AuthException extends AppException {
  AuthException({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });
}

/// Validation-related exceptions
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  ValidationException({
    required super.message,
    this.fieldErrors,
    super.code,
    super.originalException,
    super.stackTrace,
  });
}

/// Cache-related exceptions
class CacheException extends AppException {
  CacheException({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });
}

/// Payment-related exceptions
class PaymentException extends AppException {
  final String? transactionId;

  PaymentException({
    required super.message,
    this.transactionId,
    super.code,
    super.originalException,
    super.stackTrace,
  });
}

/// Geolocation-related exceptions
class LocationException extends AppException {
  LocationException({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });
}

/// Security-related exceptions
class SecurityException extends AppException {
  SecurityException({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });
}

/// Generic/unknown exceptions
class UnknownException extends AppException {
  UnknownException({
    required super.message,
    super.code,
    super.originalException,
    super.stackTrace,
  });
}

import 'package:logger/logger.dart';

/// Application-wide logger instance
final logger = Logger(
  level: Level.debug,
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);

/// Logger utility for consistent logging across the app
class AppLogger {
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.i(message, error: error, stackTrace: stackTrace);
  }

  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.w(message, error: error, stackTrace: stackTrace);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void verbose(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.v(message, error: error, stackTrace: stackTrace);
  }

  static void wtf(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.wtf(message, error: error, stackTrace: stackTrace);
  }

  static void network(
    String method,
    String path, {
    dynamic request,
    dynamic response,
    dynamic error,
  }) {
    logger.i('[$method] $path', error: error, stackTrace: StackTrace.current);
    if (request != null) logger.d('Request: $request');
    if (response != null) logger.d('Response: $response');
  }
}

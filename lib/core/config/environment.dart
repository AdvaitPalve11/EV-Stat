import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ev_stat/core/config/logger.dart';

/// Environment configuration management
class Environment {
  static late String _apiUrl;
  static late String _razorpayKeyId;
  static late String _mapsApiKey;
  static late String _firebaseProjectId;
  static late bool _isProduction;

  static Future<void> init() async {
    var loaded = false;
    try {
      await dotenv.load(fileName: '.env');
      loaded = true;
      AppLogger.info('Loaded .env file');
    } catch (e, st) {
      AppLogger.warning(
          'Environment file ".env" not found; continuing with defaults', e, st);
    }

    final env = loaded ? dotenv.env : <String, String>{};

    _apiUrl = env['API_URL'] ?? 'https://api.dev.fuelpay.app/v1';
    _razorpayKeyId = env['RAZORPAY_KEY_ID'] ?? 'rzp_test_xxxxx';
    _mapsApiKey = env['MAPS_API_KEY'] ?? '';
    _firebaseProjectId = env['FIREBASE_PROJECT_ID'] ?? '';
    _isProduction = (env['ENV'] ?? '') == 'production';
  }

  static String get apiUrl => _apiUrl;
  static String get razorpayKeyId => _razorpayKeyId;
  static String get mapsApiKey => _mapsApiKey;
  static String get firebaseProjectId => _firebaseProjectId;
  static bool get isProduction => _isProduction;
  static bool get isDevelopment => !_isProduction;
}

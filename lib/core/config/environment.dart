import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration management
class Environment {
  static late String _apiUrl;
  static late String _razorpayKeyId;
  static late String _mapsApiKey;
  static late String _firebaseProjectId;
  static late bool _isProduction;

  static Future<void> init() async {
    await dotenv.load(fileName: '.env');

    _apiUrl = dotenv.env['API_URL'] ?? 'https://api.dev.fuelpay.app/v1';
    _razorpayKeyId = dotenv.env['RAZORPAY_KEY_ID'] ?? 'rzp_test_xxxxx';
    _mapsApiKey = dotenv.env['MAPS_API_KEY'] ?? '';
    _firebaseProjectId = dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
    _isProduction = dotenv.env['ENV'] == 'production';
  }

  static String get apiUrl => _apiUrl;
  static String get razorpayKeyId => _razorpayKeyId;
  static String get mapsApiKey => _mapsApiKey;
  static String get firebaseProjectId => _firebaseProjectId;
  static bool get isProduction => _isProduction;
  static bool get isDevelopment => !_isProduction;
}

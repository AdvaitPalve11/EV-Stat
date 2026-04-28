/// Application-wide constants
abstract class AppConstants {
  // API Configuration
  static const String apiBaseUrl = 'https://api.fuelpay.app/v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;

  // Geofencing
  static const double geofenceRadius = 100.0; // meters

  // Rewards System
  static const double creditsPerRupee = 1 / 200; // ₹200 = 1 FuelCredit
  static const int maxDailyRewards = 50;
  static const int maxMonthlyRewards = 500;

  // Reward Tiers
  static const Map<String, dynamic> rewardTiers = {
    'bronze': {'minCredits': 0, 'maxCredits': 99, 'multiplier': 1.0},
    'silver': {'minCredits': 100, 'maxCredits': 499, 'multiplier': 1.25},
    'gold': {'minCredits': 500, 'maxCredits': 1499, 'multiplier': 1.5},
    'platinum': {'minCredits': 1500, 'maxCredits': 4999, 'multiplier': 2.0},
    'diamond': {'minCredits': 5000, 'maxCredits': null, 'multiplier': 3.0},
  };

  // Session & Security
  static const Duration tokenRefreshThreshold = Duration(minutes: 5);
  static const Duration sessionTimeout = Duration(hours: 24);

  // Storage Keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyDeviceId = 'device_id';
  static const String keyIsLoggedIn = 'is_logged_in';

  // Firebase
  static const String fcmTopicPayments = 'payments';
  static const String fcmTopicRewards = 'rewards';
  static const String fcmTopicPromotions = 'promotions';

  // Pagination
  static const int paginationPageSize = 20;

  // Payment States
  static const String paymentStatePending = 'pending';
  static const String paymentStateSuccess = 'success';
  static const String paymentStateFailed = 'failed';
  static const String paymentStateCancelled = 'cancelled';
  static const String paymentStateRefunded = 'refunded';

  // Razorpay
  static const String razorpayKeyId = 'rzp_live_xxxxx'; // Set from env
  static const Duration razorpayTimeout = Duration(seconds: 60);
}

/// Feature-specific constants
abstract class AuthConstants {
  static const int otpLength = 6;
  static const Duration otpValidityDuration = Duration(minutes: 10);
  static const int maxOtpRetries = 5;
}

abstract class StationConstants {
  static const int nearbyStationsRadius = 50; // km
  static const int maxNearbyStations = 100;
}

abstract class ValidationConstants {
  static const String phonePattern = r'^[6-9]\d{9}$';
  static const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const int minPasswordLength = 8;
}

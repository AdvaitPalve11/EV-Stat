import 'package:go_router/go_router.dart';

/// Application-wide router configuration
/// Routes will be added as we build each feature
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) {
      return Scaffold(body: Center(child: Text('Route error: ${state.error}')));
    },
    routes: [
      // Splash route
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) {
          // TODO: Implement splash screen in Phase 1
          return const Scaffold(body: Center(child: Text('Splash Screen')));
        },
      ),
      // More routes will be added in subsequent phases
    ],
  );
}

/// Route names - centralized for easy reference
abstract class RouteNames {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String otp = 'otp';
  static const String home = 'home';
  static const String stations = 'stations';
  static const String stationDetails = 'station-details';
  static const String qrScanner = 'qr-scanner';
  static const String payment = 'payment';
  static const String paymentStatus = 'payment-status';
  static const String wallet = 'wallet';
  static const String rewards = 'rewards';
  static const String profile = 'profile';
  static const String referrals = 'referrals';
  static const String analytics = 'analytics';
  static const String merchant = 'merchant';
  static const String fleet = 'fleet';
}

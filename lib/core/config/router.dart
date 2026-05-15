import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/navigation/app_shell.dart';
import '../../features/stations/station_detail_page.dart';

/// Application-wide router configuration
/// Routes will be added as we build each feature
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) {
      return Scaffold(body: Center(child: Text('Route error: ${state.error}')));
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) {
          return const AppShellPage();
        },
      ),
      GoRoute(
        path: '/station/:stationId',
        name: RouteNames.stationDetails,
        pageBuilder: (context, state) {
          final stationId = state.pathParameters['stationId'] ?? '';

          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: StationDetailPage(stationId: stationId),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final fade =
                  CurvedAnimation(parent: animation, curve: Curves.easeOut);
              final slide =
                  Tween<Offset>(begin: const Offset(0.08, 0), end: Offset.zero)
                      .animate(fade);

              return FadeTransition(
                opacity: fade,
                child: SlideTransition(position: slide, child: child),
              );
            },
          );
        },
      ),
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

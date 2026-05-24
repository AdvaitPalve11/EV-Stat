import 'package:flutter/material.dart';

import '../analytics/analytics_page.dart';
import '../dashboard/dashboard_page.dart';
import '../profile/profile_page.dart';
import '../stations/stations_page.dart';
import '../wallet/wallet_page.dart';
import '../../core/theme/theme_extended.dart';

class AppShellPage extends StatefulWidget {
  const AppShellPage({super.key});

  @override
  State<AppShellPage> createState() => _AppShellPageState();
}

class _AppShellPageState extends State<AppShellPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    StationsPage(),
    AnalyticsPage(),
    WalletPage(),
    ProfilePage(),
  ];

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'Home'),
    NavigationDestination(
        icon: Icon(Icons.ev_station_rounded), label: 'Stations'),
    NavigationDestination(
        icon: Icon(Icons.insights_rounded), label: 'Analytics'),
    NavigationDestination(
        icon: Icon(Icons.account_balance_wallet_rounded), label: 'Wallet'),
    NavigationDestination(icon: Icon(Icons.person_rounded), label: 'Profile'),
  ];

  void _selectTab(int index) {
    if (index == _selectedIndex) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: FuelPayTheme.blackBackground,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0B1220),
                  Color(0xFF0F172A),
                  Color(0xFF111827),
                ],
                stops: [0.0, 0.62, 1.0],
              ),
            ),
          ),
          Positioned(
            top: -100,
            right: -70,
            child: _GlowOrb(color: FuelPayTheme.accent.withValues(alpha: 0.12)),
          ),
          Positioned(
            bottom: 120,
            left: -70,
            child: _GlowOrb(
                color: FuelPayTheme.accentSoft.withValues(alpha: 0.08),
                size: 200),
          ),
          SafeArea(
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: FuelPayTheme.surface.withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: FuelPayTheme.borderLight, width: 0.7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.24),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.transparent,
            indicatorColor: FuelPayTheme.accent.withValues(alpha: 0.12),
            iconTheme: WidgetStateProperty.resolveWith((states) {
              return IconThemeData(
                color: states.contains(WidgetState.selected)
                    ? FuelPayTheme.accent
                    : FuelPayTheme.textSecondary,
                size: 21,
              );
            }),
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              return TextStyle(
                color: states.contains(WidgetState.selected)
                    ? FuelPayTheme.accent
                    : FuelPayTheme.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              );
            }),
          ),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _selectTab,
            destinations: _destinations,
            height: 74,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;

  const _GlowOrb({required this.color, this.size = 220});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0.0)],
        ),
      ),
    );
  }
}

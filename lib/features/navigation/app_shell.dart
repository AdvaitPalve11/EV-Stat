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
  final PageController _pageController = PageController();
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectTab(int index) {
    if (index == _selectedIndex) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
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
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF05070C),
                  Color(0xFF090B13),
                  Color(0xFF000000),
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),
          Positioned(
            top: -120,
            right: -80,
            child: _GlowOrb(
                color: FuelPayTheme.electricBlue.withValues(alpha: 0.22)),
          ),
          Positioned(
            bottom: 140,
            left: -60,
            child: _GlowOrb(
                color: FuelPayTheme.neonGreen.withValues(alpha: 0.12),
                size: 180),
          ),
          SafeArea(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: FuelPayTheme.charcoalCard.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: FuelPayTheme.borderLight, width: 0.5),
          boxShadow: FuelPayTheme.glassmorphicShadow,
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.transparent,
            indicatorColor: FuelPayTheme.neonGreen.withValues(alpha: 0.16),
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              return TextStyle(
                color: states.contains(WidgetState.selected)
                    ? FuelPayTheme.neonGreen
                    : FuelPayTheme.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              );
            }),
          ),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _selectTab,
            destinations: _destinations,
            height: 72,
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

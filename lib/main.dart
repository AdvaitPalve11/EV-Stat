import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/environment.dart';
import 'core/config/logger.dart';
import 'core/config/router.dart';
import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment configuration
  try {
    await Environment.init();
    AppLogger.info('Environment initialized successfully');
  } catch (e) {
    AppLogger.error('Failed to initialize environment', e);
  }

  // Initialize Hive local cache
  // TODO: Initialize Hive in Phase 7

  // Initialize Firebase
  // TODO: Initialize Firebase in Phase 3

  // Set preferred device orientations
  // TODO: Implement orientation settings

  runApp(const ProviderScope(child: FuelPayApp()));
}

class FuelPayApp extends StatelessWidget {
  const FuelPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FuelPay',
      debugShowCheckedModeBanner: false,
      theme: FuelPayTheme.lightTheme(),
      darkTheme: FuelPayTheme.darkTheme(),
      themeMode: ThemeMode.dark, // Default to dark theme
      routerConfig: AppRouter.router,
    );
  }
}

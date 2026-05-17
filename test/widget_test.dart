// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ev_stat/main.dart';
import 'package:ev_stat/core/models/app_backend_snapshot.dart';
import 'package:ev_stat/core/providers/app_backend_provider.dart';

AppBackendSnapshot _testSnapshot() {
  return AppBackendSnapshot(
    userName: 'Test User',
    tierName: 'Platinum',
    tierProgress: 0.7,
    walletBalance: 2500,
    credits: 1800,
    streakDays: 12,
    activeSessions: 2,
    pendingPayments: 1,
    backendHealth: BackendHealth.healthy,
    lastUpdated: DateTime(2026, 5, 17, 12, 0),
    insights: const ['Snapshot ready'],
    weeklyUsage: const [UsagePoint(label: 'Mon', value: 20)],
    weeklySpend: const [UsagePoint(label: 'Mon', value: 150)],
    stations: const [
      StationSnapshot(
        id: 'station-1',
        name: 'Test Station',
        area: 'Test Area',
        distanceKm: 1.2,
        availableConnectors: 4,
        totalConnectors: 6,
        pricePerKwh: 14.5,
        etaMinutes: 8,
        health: BackendHealth.healthy,
      ),
    ],
    transactions: [
      TransactionSnapshot(
        title: 'Test top up',
        subtitle: 'Widget test',
        amount: 100,
        timestamp: DateTime(2026, 5, 17, 12, 0),
        isCredit: true,
      ),
    ],
  );
}

void main() {
  testWidgets('FuelPay app builds', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          backendSnapshotProvider.overrideWith(
            (ref) => Stream<AppBackendSnapshot>.value(_testSnapshot()),
          ),
        ],
        child: const FuelPayApp(),
      ),
    );

    expect(find.byType(MaterialApp), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}

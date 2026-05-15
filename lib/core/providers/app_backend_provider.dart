import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_backend_snapshot.dart';

final backendRepositoryProvider = Provider<BackendRepository>((ref) {
  return const BackendRepository();
});

final backendSnapshotProvider =
    StreamProvider.autoDispose<AppBackendSnapshot>((ref) async* {
  final repository = ref.watch(backendRepositoryProvider);
  var cycle = 0;

  while (true) {
    yield await repository.loadSnapshot(cycle: cycle);
    cycle += 1;
    await Future<void>.delayed(const Duration(seconds: 20));
  }
});

class BackendRepository {
  const BackendRepository();

  Future<AppBackendSnapshot> loadSnapshot({required int cycle}) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));

    final cycleOffset = (cycle % 4) * 0.35;
    final health = switch (cycle % 3) {
      0 => BackendHealth.healthy,
      1 => BackendHealth.busy,
      _ => BackendHealth.degraded,
    };

    return AppBackendSnapshot(
      userName: 'Aarav Patel',
      tierName: switch (cycle % 3) {
        0 => 'Platinum',
        1 => 'Gold',
        _ => 'Diamond',
      },
      tierProgress: 0.62 + (cycle % 2) * 0.08,
      walletBalance: 2865.40 + cycleOffset * 40,
      credits: 1840 + (cycle * 40),
      streakDays: 17 + cycle % 5,
      activeSessions: 3 + cycle % 2,
      pendingPayments: 1 + (cycle % 2),
      backendHealth: health,
      lastUpdated: DateTime.now(),
      insights: [
        'Fast charge usage increased by ${(cycleOffset * 12 + 8).toStringAsFixed(1)}% this week.',
        'You have ${2 + cycle % 3} premium stations within 5 km.',
        'A payment reminder is pending for your fleet account.',
      ],
      weeklyUsage: [
        UsagePoint(label: 'Mon', value: 24 + cycleOffset * 2),
        UsagePoint(label: 'Tue', value: 30 + cycleOffset * 2.5),
        UsagePoint(label: 'Wed', value: 26 + cycleOffset * 1.4),
        UsagePoint(label: 'Thu', value: 34 + cycleOffset * 1.9),
        UsagePoint(label: 'Fri', value: 29 + cycleOffset * 2.2),
        UsagePoint(label: 'Sat', value: 37 + cycleOffset * 1.7),
        UsagePoint(label: 'Sun', value: 31 + cycleOffset * 2.8),
      ],
      weeklySpend: [
        UsagePoint(label: 'Mon', value: 180 + cycleOffset * 10),
        UsagePoint(label: 'Tue', value: 220 + cycleOffset * 8),
        UsagePoint(label: 'Wed', value: 160 + cycleOffset * 7),
        UsagePoint(label: 'Thu', value: 250 + cycleOffset * 12),
        UsagePoint(label: 'Fri', value: 210 + cycleOffset * 9),
        UsagePoint(label: 'Sat', value: 275 + cycleOffset * 14),
        UsagePoint(label: 'Sun', value: 195 + cycleOffset * 11),
      ],
      stations: [
        StationSnapshot(
          id: 'sta-01',
          name: 'Orbit Express Hub',
          area: 'Tech Park, Bangalore',
          distanceKm: 1.2 + cycleOffset,
          availableConnectors: 6 - (cycle % 3),
          totalConnectors: 8,
          pricePerKwh: 14.9 + cycleOffset,
          etaMinutes: 9 + cycle % 4,
          health: BackendHealth.healthy,
        ),
        StationSnapshot(
          id: 'sta-02',
          name: 'North Grid Station',
          area: 'Indiranagar',
          distanceKm: 2.8 + cycleOffset,
          availableConnectors: 3 + cycle % 2,
          totalConnectors: 6,
          pricePerKwh: 16.4 + cycleOffset,
          etaMinutes: 14 + cycle % 3,
          health: BackendHealth.busy,
        ),
        StationSnapshot(
          id: 'sta-03',
          name: 'Zenith Charge Point',
          area: 'Whitefield',
          distanceKm: 4.5 + cycleOffset,
          availableConnectors: 1 + cycle % 2,
          totalConnectors: 5,
          pricePerKwh: 13.8 + cycleOffset,
          etaMinutes: 22 + cycle % 4,
          health: BackendHealth.degraded,
        ),
      ],
      transactions: [
        TransactionSnapshot(
          title: 'Fast charge session',
          subtitle: 'Orbit Express Hub',
          amount: 420.0 + cycleOffset * 20,
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isCredit: false,
        ),
        TransactionSnapshot(
          title: 'Reward cashback',
          subtitle: 'Platinum tier bonus',
          amount: 85.0,
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          isCredit: true,
        ),
        TransactionSnapshot(
          title: 'Wallet top up',
          subtitle: 'UPI auto debit',
          amount: 1200.0,
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          isCredit: true,
        ),
      ],
    );
  }
}

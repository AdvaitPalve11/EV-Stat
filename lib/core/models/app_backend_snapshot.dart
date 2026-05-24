enum BackendHealth {
  healthy,
  busy,
  degraded,
}

class UsagePoint {
  final String label;
  final double value;

  const UsagePoint({required this.label, required this.value});
}

class StationSnapshot {
  final String id;
  final String name;
  final String area;
  final double distanceKm;
  final int availableConnectors;
  final int totalConnectors;
  final double pricePerKwh;
  final int etaMinutes;
  final BackendHealth health;

  const StationSnapshot({
    required this.id,
    required this.name,
    required this.area,
    required this.distanceKm,
    required this.availableConnectors,
    required this.totalConnectors,
    required this.pricePerKwh,
    required this.etaMinutes,
    required this.health,
  });

  double get availability =>
      totalConnectors == 0 ? 0 : availableConnectors / totalConnectors;
}

class TransactionSnapshot {
  final String title;
  final String subtitle;
  final double amount;
  final DateTime timestamp;
  final bool isCredit;

  const TransactionSnapshot({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.timestamp,
    required this.isCredit,
  });
}

class AppBackendSnapshot {
  final String userName;
  final String tierName;
  final double tierProgress;
  final double walletBalance;
  final int credits;
  final int streakDays;
  final int activeSessions;
  final int pendingPayments;
  final BackendHealth backendHealth;
  final DateTime lastUpdated;
  final List<String> insights;
  final List<UsagePoint> weeklyUsage;
  final List<UsagePoint> weeklySpend;
  final List<StationSnapshot> stations;
  final List<TransactionSnapshot> transactions;

  const AppBackendSnapshot({
    required this.userName,
    required this.tierName,
    required this.tierProgress,
    required this.walletBalance,
    required this.credits,
    required this.streakDays,
    required this.activeSessions,
    required this.pendingPayments,
    required this.backendHealth,
    required this.lastUpdated,
    required this.insights,
    required this.weeklyUsage,
    required this.weeklySpend,
    required this.stations,
    required this.transactions,
  });
}

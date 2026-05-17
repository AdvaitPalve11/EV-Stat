import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/app_backend_snapshot.dart';
import '../../core/providers/app_backend_provider.dart';
import '../../core/theme/theme_extended.dart';
import '../../core/widgets/widgets.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(backendSnapshotProvider);

    return Scaffold(
      appBar: const FuelPayAppBar(
        title: 'FuelPay Dashboard',
        isTransparent: true,
      ),
      body: snapshot.when(
        loading: () => const _DashboardLoadingState(),
        error: (error, stackTrace) => ErrorState(
          title: 'Unable to load dashboard',
          message:
              'The backend feed is unavailable right now. Pull to retry once it is restored.',
          onRetry: () => ref.invalidate(backendSnapshotProvider),
        ),
        data: (data) => RefreshIndicator(
          color: FuelPayTheme.neonGreen,
          onRefresh: () async {
            ref.invalidate(backendSnapshotProvider);
            await ref.read(backendSnapshotProvider.future);
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      _HeroSummaryCard(data: data),
                      const SizedBox(height: 16),
                      _GamificationBanner(data: data),
                      const SizedBox(height: 16),
                      _SectionTitle(
                        title: 'Live metrics',
                        subtitle:
                            'Key values refresh as the backend feed updates.',
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _MetricTile(
                            label: 'Wallet balance',
                            value: '₹${data.walletBalance.toStringAsFixed(0)}',
                            icon: Icons.account_balance_wallet_rounded,
                            accent: FuelPayTheme.neonGreen,
                          ),
                          _MetricTile(
                            label: 'Credits',
                            value: data.credits.toString(),
                            icon: Icons.bolt_rounded,
                            accent: FuelPayTheme.electricBlue,
                          ),
                          _MetricTile(
                            label: 'Streak',
                            value: '${data.streakDays} days',
                            icon: Icons.local_fire_department_rounded,
                            accent: FuelPayTheme.warningOrange,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _SectionTitle(
                        title: 'Usage trend',
                        subtitle: 'Seven-day energy pattern from the backend.',
                      ),
                      const SizedBox(height: 12),
                      AnimatedFuelPayCard(
                        child: SizedBox(
                          height: 260,
                          child: _UsageLineChart(points: data.weeklyUsage),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _SectionTitle(
                        title: 'Quick actions',
                        subtitle: 'One tap into the most common journeys.',
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: const [
                          _QuickActionChip(
                              label: 'Scan QR',
                              icon: Icons.qr_code_scanner_rounded),
                          _QuickActionChip(
                              label: 'Find station',
                              icon: Icons.location_on_rounded),
                          _QuickActionChip(
                              label: 'Add funds', icon: Icons.add_card_rounded),
                          _QuickActionChip(
                              label: 'Support',
                              icon: Icons.support_agent_rounded),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _SectionTitle(
                        title: 'Recent activity',
                        subtitle: 'Latest transactions, refreshed live.',
                      ),
                      const SizedBox(height: 12),
                      ...data.transactions.map(
                        (transaction) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: AnimatedFuelPayCard(
                            child: _TransactionTile(transaction: transaction),
                          ),
                        ),
                      ),
                      const SizedBox(height: 88),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardLoadingState extends StatelessWidget {
  const _DashboardLoadingState();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      physics: const AlwaysScrollableScrollPhysics(),
      children: const [
        SkeletonHeroCard(),
        SizedBox(height: 16),
        SkeletalLoader(height: 180),
        SizedBox(height: 16),
        SkeletalLoader(height: 120),
        SizedBox(height: 16),
        SkeletalLoader(height: 260),
        SizedBox(height: 16),
        SkeletalLoader(height: 84),
        SizedBox(height: 12),
        SkeletalLoader(height: 84),
      ],
    );
  }
}

class _GamificationBanner extends StatelessWidget {
  final AppBackendSnapshot data;

  const _GamificationBanner({required this.data});

  @override
  Widget build(BuildContext context) {
    final missionProgress = data.tierProgress.clamp(0.0, 1.0);

    return AnimatedFuelPayCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: FuelPayTheme.neonGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.rocket_launch_rounded,
                  color: FuelPayTheme.blackBackground,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily mission',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Stay active to unlock more rewards and station perks.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: FuelPayTheme.neonGreen.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${(missionProgress * 100).toStringAsFixed(0)}% XP',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: FuelPayTheme.neonGreen,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: missionProgress,
              minHeight: 10,
              backgroundColor: FuelPayTheme.darkSurface2,
              valueColor: const AlwaysStoppedAnimation<Color>(
                FuelPayTheme.electricBlue,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _MiniMetric(
                  label: 'Tier',
                  value: data.tierName,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MiniMetric(
                  label: 'Streak',
                  value: '${data.streakDays} days',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MiniMetric(
                  label: 'Credits',
                  value: data.credits.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniMetric extends StatelessWidget {
  final String label;
  final String value;

  const _MiniMetric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _HeroSummaryCard extends StatelessWidget {
  final AppBackendSnapshot data;

  const _HeroSummaryCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final statusText = switch (data.backendHealth) {
      BackendHealth.healthy => 'Backend healthy',
      BackendHealth.busy => 'Backend syncing',
      BackendHealth.degraded => 'Backend degraded',
    };

    final statusColor = switch (data.backendHealth) {
      BackendHealth.healthy => FuelPayTheme.successGreen,
      BackendHealth.busy => FuelPayTheme.warningOrange,
      BackendHealth.degraded => FuelPayTheme.errorRed,
    };

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF111827), Color(0xFF0A0F1A), Color(0xFF05070C)],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: FuelPayTheme.borderLight, width: 0.5),
        boxShadow: FuelPayTheme.glassmorphicShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${data.userName.split(' ').first}',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Everything important in one place, refreshed live from backend state.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lens_rounded, size: 10, color: statusColor),
                    const SizedBox(width: 8),
                    Text(
                      statusText,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _HeroStat(
                  label: 'Tier',
                  value: data.tierName,
                  caption:
                      'Progress ${(data.tierProgress * 100).toStringAsFixed(0)}%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _HeroStat(
                  label: 'Active sessions',
                  value: data.activeSessions.toString(),
                  caption:
                      '${data.pendingPayments} pending payment${data.pendingPayments == 1 ? '' : 's'}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: data.tierProgress,
              minHeight: 10,
              backgroundColor: FuelPayTheme.charcoalCard.withValues(alpha: 0.9),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(FuelPayTheme.neonGreen),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Last synced ${_formatTime(data.lastUpdated)}',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: FuelPayTheme.textTertiary),
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String label;
  final String value;
  final String caption;

  const _HeroStat(
      {required this.label, required this.value, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 4),
          Text(caption, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color accent;

  const _MetricTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 44) / 3,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: FuelPayTheme.charcoalCard.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: accent.withValues(alpha: 0.22)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: accent),
            const SizedBox(height: 18),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _UsageLineChart extends StatelessWidget {
  final List<UsagePoint> points;

  const _UsageLineChart({required this.points});

  @override
  Widget build(BuildContext context) {
    final spots = points.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.value);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 10,
          getDrawingHorizontalLine: (value) => FlLine(
            color: FuelPayTheme.borderLight.withValues(alpha: 0.35),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= points.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    points[index].label,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 42,
              interval: 10,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: Theme.of(context).textTheme.labelSmall,
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (points.length - 1).toDouble(),
        minY: 0,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: FuelPayTheme.neonGreen,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: FuelPayTheme.blackBackground,
                  strokeWidth: 3,
                  strokeColor: FuelPayTheme.neonGreen,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  FuelPayTheme.neonGreen.withValues(alpha: 0.35),
                  FuelPayTheme.neonGreen.withValues(alpha: 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _QuickActionChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: () {},
      avatar: Icon(icon, size: 18, color: FuelPayTheme.neonGreen),
      label: Text(label),
      backgroundColor: FuelPayTheme.charcoalCard,
      labelStyle: Theme.of(context)
          .textTheme
          .labelLarge
          ?.copyWith(color: FuelPayTheme.textPrimary),
      side: BorderSide(color: FuelPayTheme.borderLight.withValues(alpha: 0.8)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final TransactionSnapshot transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final amountColor = transaction.isCredit
        ? FuelPayTheme.successGreen
        : FuelPayTheme.warningOrange;
    final sign = transaction.isCredit ? '+' : '-';

    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: amountColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
                transaction.isCredit ? Icons.add_rounded : Icons.remove_rounded,
                color: amountColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.title,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(transaction.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 4),
                Text(_formatTime(transaction.timestamp),
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Text(
            '$sign₹${transaction.amount.toStringAsFixed(0)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: amountColor,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitle({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class SkeletonHeroCard extends StatelessWidget {
  const SkeletonHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: FuelPayTheme.charcoalCard.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(28),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletalLoader(height: 28, width: 180),
          SizedBox(height: 16),
          SkeletalLoader(height: 14),
          SizedBox(height: 16),
          SkeletalLoader(height: 18),
          SizedBox(height: 12),
          SkeletalLoader(height: 18),
        ],
      ),
    );
  }
}

String _formatTime(DateTime time) {
  final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
  final minute = time.minute.toString().padLeft(2, '0');
  final suffix = time.hour >= 12 ? 'PM' : 'AM';
  return '$hour:$minute $suffix';
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/app_backend_snapshot.dart';
import '../../core/providers/app_backend_provider.dart';
import '../../core/theme/theme_extended.dart';
import '../../core/widgets/widgets.dart';

class AnalyticsPage extends ConsumerWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(backendSnapshotProvider);

    return Scaffold(
      appBar: const FuelPayAppBar(title: 'Analytics', isTransparent: true),
      body: snapshot.when(
        loading: () => const Center(child: FuelPayLoadingIndicator()),
        error: (error, stackTrace) => ErrorState(
          title: 'Analytics offline',
          message:
              'We cannot render charts until the backend feed comes back online.',
          onRetry: () => ref.invalidate(backendSnapshotProvider),
        ),
        data: (data) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            children: [
              _AnalyticsHero(data: data),
              const SizedBox(height: 16),
              _PerformancePulseCard(data: data),
              const SizedBox(height: 16),
              AnimatedFuelPayCard(
                child: SizedBox(
                  height: 250,
                  child: _BarSpendChart(points: data.weeklySpend),
                ),
              ),
              const SizedBox(height: 16),
              AnimatedFuelPayCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Insights',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    ...data.insights.map(
                      (insight) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _InsightRow(text: insight),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AnimatedFuelPayCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Membership ladder',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    TierLadder(
                      currentTierIndex: _tierIndex(data.tierName),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AnalyticsHero extends StatelessWidget {
  final AppBackendSnapshot data;

  const _AnalyticsHero({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF111827), Color(0xFF0B1020), Color(0xFF06070D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: FuelPayTheme.borderLight, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Performance overview',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'The charts below redraw whenever the backend snapshot updates.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _MiniMetric(
                  label: 'Weekly spend',
                  value: '₹${_sum(data.weeklySpend).toStringAsFixed(0)}'),
              _MiniMetric(
                  label: 'Usage peak',
                  value: '${_peak(data.weeklyUsage).toStringAsFixed(1)} kWh'),
              _MiniMetric(
                  label: 'Backend',
                  value: data.backendHealth.name.toUpperCase()),
            ],
          ),
        ],
      ),
    );
  }

  double _sum(List<UsagePoint> points) {
    return points.fold<double>(0, (sum, point) => sum + point.value);
  }

  double _peak(List<UsagePoint> points) {
    return points
        .map((point) => point.value)
        .fold<double>(0, (max, value) => value > max ? value : max);
  }
}

class _PerformancePulseCard extends StatelessWidget {
  final AppBackendSnapshot data;

  const _PerformancePulseCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final progress = data.tierProgress.clamp(0.0, 1.0);

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
                  Icons.analytics_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Performance pulse',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Usage trends, spend patterns, and membership status in one place.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: FuelPayTheme.darkSurface2,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(FuelPayTheme.accent),
            ),
          ),
          const SizedBox(height: 12),
          RewardTierBadge(
            tierName: data.tierName,
            multiplier: data.tierName.toLowerCase() == 'diamond'
                ? 2.5
                : data.tierName.toLowerCase() == 'platinum'
                    ? 2.0
                    : 1.5,
            currentCredits: data.credits,
            maxCredits: 5000,
          ),
        ],
      ),
    );
  }
}

int _tierIndex(String tierName) {
  switch (tierName.toLowerCase()) {
    case 'bronze':
      return 0;
    case 'silver':
      return 1;
    case 'gold':
      return 2;
    case 'platinum':
      return 3;
    case 'diamond':
      return 4;
    default:
      return 0;
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _BarSpendChart extends StatelessWidget {
  final List<UsagePoint> points;

  const _BarSpendChart({required this.points});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 100,
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
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= points.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(points[index].label,
                      style: Theme.of(context).textTheme.labelSmall),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 44,
              interval: 100,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: points.asMap().entries.map((entry) {
          return BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value.value,
                width: 16,
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [FuelPayTheme.electricBlue, FuelPayTheme.neonGreen],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _InsightRow extends StatelessWidget {
  final String text;

  const _InsightRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 7),
          decoration: const BoxDecoration(
            color: FuelPayTheme.neonGreen,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

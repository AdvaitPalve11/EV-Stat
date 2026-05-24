import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/app_backend_snapshot.dart';
import '../../core/providers/app_backend_provider.dart';
import '../../core/theme/theme_extended.dart';
import '../../core/widgets/widgets.dart';

class StationDetailPage extends ConsumerWidget {
  final String stationId;

  const StationDetailPage({super.key, required this.stationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(backendSnapshotProvider);

    return Scaffold(
      appBar:
          const FuelPayAppBar(title: 'Station details', isTransparent: true),
      body: snapshot.when(
        loading: () => const Center(child: FuelPayLoadingIndicator()),
        error: (error, stackTrace) => ErrorState(
          title: 'Station unavailable',
          message:
              'The selected station could not be loaded from the backend feed.',
          onRetry: () => ref.invalidate(backendSnapshotProvider),
        ),
        data: (data) {
          final station =
              data.stations.where((entry) => entry.id == stationId).firstOrNull;

          if (station == null) {
            return const EmptyState(
              title: 'Station not found',
              description: 'That station is no longer in the live feed.',
              icon: Icons.ev_station_outlined,
            );
          }

          final statusColor = switch (station.health) {
            BackendHealth.healthy => FuelPayTheme.successGreen,
            BackendHealth.busy => FuelPayTheme.warningOrange,
            BackendHealth.degraded => FuelPayTheme.errorRed,
          };

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF111827),
                      Color(0xFF0B1020),
                      Color(0xFF06070D)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(26),
                  border:
                      Border.all(color: FuelPayTheme.borderLight, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.ev_station_rounded,
                              color: statusColor),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(station.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const SizedBox(height: 4),
                              Text(station.area,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _Chip(
                            label:
                                '${station.distanceKm.toStringAsFixed(1)} km away',
                            color: FuelPayTheme.electricBlue),
                        _Chip(
                            label:
                                '${station.availableConnectors}/${station.totalConnectors} free',
                            color: FuelPayTheme.neonGreen),
                        _Chip(
                            label: '${station.etaMinutes} min ETA',
                            color: statusColor),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AnimatedFuelPayCard(
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: FuelPayTheme.neonGradient,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.bolt_rounded,
                        color: FuelPayTheme.blackBackground,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Live connector overview',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Reserve this stop and keep your operations moving with current availability data.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AnimatedFuelPayCard(
                child: SizedBox(
                  height: 220,
                  child: _OccupancyChart(station: station),
                ),
              ),
              const SizedBox(height: 16),
              AnimatedFuelPayCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Station summary',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    _InfoRow(
                        label: 'Price',
                        value:
                            '₹${station.pricePerKwh.toStringAsFixed(1)} per kWh'),
                    const SizedBox(height: 12),
                    _InfoRow(
                        label: 'Availability',
                        value: '${(station.availability * 100).toInt()}%'),
                    const SizedBox(height: 12),
                    _InfoRow(
                        label: 'Status', value: _statusLabel(station.health)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AnimatedFuelPayCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Membership status',
                      style: Theme.of(context).textTheme.titleLarge,
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
              ),
              const SizedBox(height: 16),
              FuelPayButton(
                  label: 'Start navigation',
                  onPressed: () {},
                  variant: FuelPayButtonVariant.primary),
              const SizedBox(height: 12),
              FuelPayButton(
                  label: 'Reserve connector',
                  onPressed: () {},
                  variant: FuelPayButtonVariant.secondary),
            ],
          );
        },
      ),
    );
  }

  String _statusLabel(BackendHealth health) {
    return switch (health) {
      BackendHealth.healthy => 'Available',
      BackendHealth.busy => 'Busy',
      BackendHealth.degraded => 'Maintenance',
    };
  }
}

class _OccupancyChart extends StatelessWidget {
  final StationSnapshot station;

  const _OccupancyChart({required this.station});

  @override
  Widget build(BuildContext context) {
    final occupancy = station.availability * 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Connector occupancy',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 14),
        Expanded(
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 54,
              sectionsSpace: 4,
              sections: [
                PieChartSectionData(
                  value: occupancy,
                  color: FuelPayTheme.neonGreen,
                  radius: 32,
                  title: '${occupancy.toInt()}%',
                  titleStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800),
                ),
                PieChartSectionData(
                  value: 100 - occupancy,
                  color: FuelPayTheme.charcoalCard,
                  radius: 24,
                  title: '',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;

  const _Chip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Text(label,
          style:
              Theme.of(context).textTheme.labelMedium?.copyWith(color: color)),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const Spacer(),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w700)),
      ],
    );
  }
}

extension _FirstOrNullExtension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

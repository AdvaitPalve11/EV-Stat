import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/router.dart';
import '../../core/models/app_backend_snapshot.dart';
import '../../core/providers/app_backend_provider.dart';
import '../../core/theme/theme_extended.dart';
import '../../core/widgets/widgets.dart';

class StationsPage extends ConsumerStatefulWidget {
  const StationsPage({super.key});

  @override
  ConsumerState<StationsPage> createState() => _StationsPageState();
}

class _StationsPageState extends ConsumerState<StationsPage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilter = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final snapshot = ref.watch(backendSnapshotProvider);

    return Scaffold(
      appBar:
          const FuelPayAppBar(title: 'Nearby stations', isTransparent: true),
      body: snapshot.when(
        loading: () => const Center(child: FuelPayLoadingIndicator()),
        error: (error, stackTrace) => ErrorState(
          title: 'Station feed unavailable',
          message:
              'We could not reach the live station inventory. Pull down to try again.',
          onRetry: () => ref.invalidate(backendSnapshotProvider),
        ),
        data: (data) {
          final filteredStations = _filterStations(data.stations);

          return RefreshIndicator(
            color: FuelPayTheme.neonGreen,
            onRefresh: () async {
              ref.invalidate(backendSnapshotProvider);
              await ref.read(backendSnapshotProvider.future);
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
              children: [
                _StationsHeroCard(data: data),
                const SizedBox(height: 16),
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded),
                    hintText: 'Search by station or area',
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _FilterChip(
                      label: 'All',
                      selected: _selectedFilter == 0,
                      onTap: () => setState(() => _selectedFilter = 0),
                    ),
                    _FilterChip(
                      label: 'Available',
                      selected: _selectedFilter == 1,
                      onTap: () => setState(() => _selectedFilter = 1),
                    ),
                    _FilterChip(
                      label: 'Busy',
                      selected: _selectedFilter == 2,
                      onTap: () => setState(() => _selectedFilter = 2),
                    ),
                    _FilterChip(
                      label: 'Offline',
                      selected: _selectedFilter == 3,
                      onTap: () => setState(() => _selectedFilter = 3),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...filteredStations.map(
                  (station) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AnimatedFuelPayCard(
                      child: _StationCard(
                        station: station,
                        onTap: () => context.pushNamed(
                          RouteNames.stationDetails,
                          pathParameters: {'stationId': station.id},
                        ),
                      ),
                    ),
                  ),
                ),
                if (filteredStations.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: EmptyState(
                      title: 'No matching stations',
                      description:
                          'Try a different search or switch to a broader filter.',
                      icon: Icons.ev_station_outlined,
                      actionButton: TextButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _selectedFilter = 0);
                        },
                        child: const Text('Reset filters'),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<StationSnapshot> _filterStations(List<StationSnapshot> stations) {
    final query = _searchController.text.trim().toLowerCase();

    return stations.where((station) {
      final matchesQuery = query.isEmpty ||
          station.name.toLowerCase().contains(query) ||
          station.area.toLowerCase().contains(query);

      final matchesFilter = switch (_selectedFilter) {
        1 => station.availableConnectors > 0,
        2 => station.health == BackendHealth.busy,
        3 => station.health == BackendHealth.degraded,
        _ => true,
      };

      return matchesQuery && matchesFilter;
    }).toList();
  }
}

class _StationsHeroCard extends StatelessWidget {
  final AppBackendSnapshot data;

  const _StationsHeroCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF111827), Color(0xFF0C1220), Color(0xFF070B13)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: FuelPayTheme.borderLight, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Live station inventory',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Stations, pricing, and connector availability will update when backend data changes.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: _MiniStat(
                      label: 'Nearby', value: '${data.stations.length}')),
              const SizedBox(width: 10),
              Expanded(
                  child: _MiniStat(
                      label: 'Available',
                      value:
                          '${data.stations.where((station) => station.availableConnectors > 0).length}')),
              const SizedBox(width: 10),
              Expanded(
                  child: _MiniStat(
                      label: 'Average price',
                      value:
                          '₹${_averagePrice(data.stations).toStringAsFixed(1)}')),
            ],
          ),
        ],
      ),
    );
  }

  double _averagePrice(List<StationSnapshot> stations) {
    if (stations.isEmpty) {
      return 0;
    }

    final total =
        stations.fold<double>(0, (sum, station) => sum + station.pricePerKwh);
    return total / stations.length;
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;

  const _MiniStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: FuelPayTheme.neonGreen.withValues(alpha: 0.15),
      backgroundColor: FuelPayTheme.charcoalCard,
      labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
            color:
                selected ? FuelPayTheme.neonGreen : FuelPayTheme.textSecondary,
          ),
      side: BorderSide(
          color: selected ? FuelPayTheme.neonGreen : FuelPayTheme.borderLight),
    );
  }
}

class _StationCard extends StatelessWidget {
  final StationSnapshot station;
  final VoidCallback onTap;

  const _StationCard({required this.station, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (station.health) {
      BackendHealth.healthy => FuelPayTheme.successGreen,
      BackendHealth.busy => FuelPayTheme.warningOrange,
      BackendHealth.degraded => FuelPayTheme.errorRed,
    };

    final statusLabel = switch (station.health) {
      BackendHealth.healthy => 'Available',
      BackendHealth.busy => 'Busy',
      BackendHealth.degraded => 'Attention',
    };

    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(Icons.ev_station_rounded, color: statusColor),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(station.name,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(station.area,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _Badge(label: statusLabel, color: statusColor),
                        _Badge(
                            label:
                                '${station.distanceKm.toStringAsFixed(1)} km',
                            color: FuelPayTheme.electricBlue),
                        _Badge(
                            label:
                                '${station.availableConnectors}/${station.totalConnectors} open',
                            color: FuelPayTheme.neonGreen),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: _ValueTile(
                      label: 'Price',
                      value: '₹${station.pricePerKwh.toStringAsFixed(1)}/kWh')),
              const SizedBox(width: 10),
              Expanded(
                  child: _ValueTile(
                      label: 'ETA', value: '${station.etaMinutes} min')),
              const SizedBox(width: 10),
              Expanded(
                  child: _ValueTile(
                      label: 'Availability',
                      value: '${(station.availability * 100).toInt()}%')),
            ],
          ),
          const SizedBox(height: 16),
          FuelPayButton(
            label: 'View details',
            onPressed: onTap,
            variant: FuelPayButtonVariant.primary,
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;

  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _ValueTile extends StatelessWidget {
  final String label;
  final String value;

  const _ValueTile({required this.label, required this.value});

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
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 6),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/app_backend_provider.dart';
import '../../core/theme/theme_extended.dart';
import '../../core/widgets/widgets.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(backendSnapshotProvider);

    return Scaffold(
      appBar: const FuelPayAppBar(title: 'Profile', isTransparent: true),
      body: snapshot.when(
        loading: () => const Center(child: FuelPayLoadingIndicator()),
        error: (error, stackTrace) => ErrorState(
          title: 'Profile unavailable',
          message:
              'Your profile data will reappear when the backend feed responds again.',
          onRetry: () => ref.invalidate(backendSnapshotProvider),
        ),
        data: (data) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            children: [
              AnimatedFuelPayCard(
                child: Row(
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        gradient: FuelPayTheme.neonGradient,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(Icons.person_rounded,
                          color: FuelPayTheme.blackBackground, size: 34),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.userName,
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 4),
                          Text(
                              'Tier ${data.tierName} · ${data.credits} credits',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
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
                    Text('Session settings',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: true,
                      onChanged: (_) {},
                      title: const Text('Push notifications'),
                      subtitle: const Text(
                          'Receive live alerts for payments and station changes'),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: false,
                      onChanged: (_) {},
                      title: const Text('Night charge mode'),
                      subtitle: const Text(
                          'Prefer lower tariff windows when possible'),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: true,
                      onChanged: (_) {},
                      title: const Text('Data saver'),
                      subtitle: const Text(
                          'Reduce image and chart refresh frequency'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AnimatedFuelPayCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Backend sync',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    _InfoLine(label: 'Health', value: data.backendHealth.name),
                    const SizedBox(height: 8),
                    _InfoLine(
                        label: 'Last synced',
                        value: _formatTime(data.lastUpdated)),
                    const SizedBox(height: 8),
                    _InfoLine(
                        label: 'Pending payments',
                        value: data.pendingPayments.toString()),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FuelPayButton(
                  label: 'Sign out',
                  onPressed: () {},
                  variant: FuelPayButtonVariant.outline),
            ],
          );
        },
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final String label;
  final String value;

  const _InfoLine({required this.label, required this.value});

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

String _formatTime(DateTime time) {
  final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
  final minute = time.minute.toString().padLeft(2, '0');
  final suffix = time.hour >= 12 ? 'PM' : 'AM';
  return '$hour:$minute $suffix';
}

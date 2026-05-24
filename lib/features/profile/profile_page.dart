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
                            '${data.tierName} account · ${data.credits} credits',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              StreakMeter(currentStreak: data.streakDays, streakBonus: 12),
              const SizedBox(height: 16),
              AnimatedFuelPayCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Operational settings',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: true,
                      onChanged: (_) {},
                      title: const Text('Push notifications'),
                      subtitle: const Text(
                          'Receive live alerts for payments and station updates'),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: false,
                      onChanged: (_) {},
                      title: const Text('Off-peak preference'),
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
                    Text('Account milestones',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: const [
                        SizedBox(
                          width: 150,
                          child: AchievementBadge(
                            title: 'First session',
                            description:
                                'Initial usage completed on the platform.',
                            icon: Icons.flash_on_rounded,
                            color: FuelPayTheme.electricBlue,
                            isUnlocked: true,
                            unlockedDate: 'Today',
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: AchievementBadge(
                            title: 'Consistency',
                            description: 'Maintain steady usage over time.',
                            icon: Icons.local_fire_department_rounded,
                            color: FuelPayTheme.neonGreen,
                            isUnlocked: true,
                            unlockedDate: 'This week',
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: AchievementBadge(
                            title: 'Prepared wallet',
                            description:
                                'Keep your balance ready for future sessions.',
                            icon: Icons.account_balance_wallet_rounded,
                            color: FuelPayTheme.warningOrange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AnimatedFuelPayCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Membership ladder',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    TierLadder(currentTierIndex: _tierIndex(data.tierName)),
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

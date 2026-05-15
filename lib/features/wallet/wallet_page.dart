import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/app_backend_snapshot.dart';
import '../../core/providers/app_backend_provider.dart';
import '../../core/theme/theme_extended.dart';
import '../../core/widgets/widgets.dart';

class WalletPage extends ConsumerWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(backendSnapshotProvider);

    return Scaffold(
      appBar: const FuelPayAppBar(title: 'Wallet', isTransparent: true),
      body: snapshot.when(
        loading: () => const Center(child: FuelPayLoadingIndicator()),
        error: (error, stackTrace) => ErrorState(
          title: 'Wallet offline',
          message:
              'Wallet content will appear again when the backend feed reconnects.',
          onRetry: () => ref.invalidate(backendSnapshotProvider),
        ),
        data: (data) {
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
                  borderRadius: BorderRadius.circular(24),
                  border:
                      Border.all(color: FuelPayTheme.borderLight, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Available balance',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text('₹${data.walletBalance.toStringAsFixed(0)}',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    Text('Updated live from backend feed',
                        style: Theme.of(context).textTheme.bodyMedium),
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
                    Text('Transactions',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    ...data.transactions.map(
                      (transaction) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _TransactionRow(transaction: transaction),
                      ),
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

class _TransactionRow extends StatelessWidget {
  final TransactionSnapshot transaction;

  const _TransactionRow({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final color = transaction.isCredit
        ? FuelPayTheme.successGreen
        : FuelPayTheme.warningOrange;
    final sign = transaction.isCredit ? '+' : '-';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
                transaction.isCredit
                    ? Icons.arrow_downward_rounded
                    : Icons.arrow_upward_rounded,
                color: color,
                size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.title,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(transaction.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          Text(
            '$sign₹${transaction.amount.toStringAsFixed(0)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

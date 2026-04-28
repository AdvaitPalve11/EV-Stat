import 'package:flutter/material.dart';
import '../theme/theme_extended.dart';

/// Reward Tier Badge - Display user's current reward tier
class RewardTierBadge extends StatelessWidget {
  final String tierName;
  final double multiplier;
  final int currentCredits;
  final int maxCredits;

  const RewardTierBadge({
    super.key,
    required this.tierName,
    required this.multiplier,
    required this.currentCredits,
    required this.maxCredits,
  });

  Color _getTierColor() {
    return switch (tierName.toLowerCase()) {
      'bronze' => const Color(0xFFCD7F32),
      'silver' => const Color(0xFFC0C0C0),
      'gold' => const Color(0xFFFFD700),
      'platinum' => const Color(0xFFE5E4E2),
      'diamond' => FuelPayTheme.neonGreen,
      _ => FuelPayTheme.electricBlue,
    };
  }

  @override
  Widget build(BuildContext context) {
    final tierColor = _getTierColor();
    final progress = currentCredits / maxCredits;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [tierColor.withOpacity(0.2), tierColor.withOpacity(0.05)],
        ),
        border: Border.all(color: tierColor.withOpacity(0.5), width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tier Name and Multiplier
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: tierColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tierName,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: tierColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${multiplier}x Multiplier',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: FuelPayTheme.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: FuelPayTheme.charcoalCard,
              valueColor: AlwaysStoppedAnimation<Color>(tierColor),
            ),
          ),
          const SizedBox(height: 8),
          // Progress Text
          Text(
            '$currentCredits / $maxCredits Credits',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: FuelPayTheme.textTertiary),
          ),
        ],
      ),
    );
  }
}

/// Streak Meter - Display current streak and bonus
class StreakMeter extends StatelessWidget {
  final int currentStreak;
  final int streakBonus; // Percentage bonus

  const StreakMeter({
    super.key,
    required this.currentStreak,
    required this.streakBonus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            FuelPayTheme.neonGreen.withOpacity(0.15),
            FuelPayTheme.neonGreen.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: FuelPayTheme.neonGreen.withOpacity(0.5),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Streak Count
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🔥 Streak',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: FuelPayTheme.neonGreen,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$currentStreak Days',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: FuelPayTheme.neonGreen,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          // Bonus Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: FuelPayTheme.neonGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  'Bonus',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: FuelPayTheme.blackBackground,
                  ),
                ),
                Text(
                  '+$streakBonus%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: FuelPayTheme.blackBackground,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Tier Ladder - Show tier progression
class TierLadder extends StatelessWidget {
  final List<String> tiers;
  final int currentTierIndex;
  final List<int> tierCreditsRequired;

  const TierLadder({
    super.key,
    this.tiers = const ['Bronze', 'Silver', 'Gold', 'Platinum', 'Diamond'],
    required this.currentTierIndex,
    this.tierCreditsRequired = const [0, 100, 500, 1500, 5000],
  });

  Color _getTierColor(int index) {
    return switch (tiers[index].toLowerCase()) {
      'bronze' => const Color(0xFFCD7F32),
      'silver' => const Color(0xFFC0C0C0),
      'gold' => const Color(0xFFFFD700),
      'platinum' => const Color(0xFFE5E4E2),
      'diamond' => FuelPayTheme.neonGreen,
      _ => FuelPayTheme.electricBlue,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reward Tiers', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tiers.length,
          itemBuilder: (context, index) {
            final isCurrentTier = index == currentTierIndex;
            final tierColor = _getTierColor(index);

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isCurrentTier ? tierColor : FuelPayTheme.borderLight,
                  width: isCurrentTier ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
                color: isCurrentTier
                    ? tierColor.withOpacity(0.1)
                    : Colors.transparent,
              ),
              child: Row(
                children: [
                  // Tier Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: tierColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        tiers[index][0],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: tierColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Tier Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              tiers[index],
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: tierColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            if (isCurrentTier)
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: tierColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Current',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(color: tierColor),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${tierCreditsRequired[index]} credits required',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: FuelPayTheme.textTertiary),
                        ),
                      ],
                    ),
                  ),
                  // Multiplier Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: tierColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${1 + (index * 0.25)}x',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: tierColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

/// Achievement Badge - Display earned achievements/milestones
class AchievementBadge extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isUnlocked;
  final String? unlockedDate;

  const AchievementBadge({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.isUnlocked = false,
    this.unlockedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: isUnlocked ? color.withOpacity(0.5) : FuelPayTheme.borderLight,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
        color: isUnlocked
            ? color.withOpacity(0.1)
            : FuelPayTheme.charcoalCard.withOpacity(0.5),
      ),
      child: Column(
        children: [
          // Badge Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isUnlocked
                  ? color.withOpacity(0.2)
                  : FuelPayTheme.textTertiary.withOpacity(0.1),
            ),
            child: Icon(
              icon,
              color: isUnlocked ? color : FuelPayTheme.textTertiary,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isUnlocked ? color : FuelPayTheme.textTertiary,
            ),
          ),
          const SizedBox(height: 4),
          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: FuelPayTheme.textTertiary),
          ),
          if (isUnlocked && unlockedDate != null) ...[
            const SizedBox(height: 8),
            Text(
              'Unlocked: $unlockedDate',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: FuelPayTheme.textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

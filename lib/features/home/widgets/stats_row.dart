import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class StatsRow extends StatelessWidget {
  final int streak;
  final int achievements;
  final double totalLoss;

  const StatsRow({
    super.key,
    required this.streak,
    required this.achievements,
    required this.totalLoss,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatItem(
          icon: Icons.local_fire_department,
          iconColor: AppColors.warmOrange,
          value: '$streak',
          label: '连续打卡',
          unit: '天',
        ),
        const SizedBox(width: 12),
        _StatItem(
          icon: Icons.emoji_events,
          iconColor: AppColors.lemonYellow,
          value: '$achievements',
          label: '已解锁成就',
          unit: '个',
        ),
        const SizedBox(width: 12),
        _StatItem(
          icon: Icons.trending_down,
          iconColor: AppColors.mintGreen,
          value: totalLoss.toStringAsFixed(1),
          label: '累计减重',
          unit: 'kg',
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final String unit;

  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.bgWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  unit,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

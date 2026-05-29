import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class WeightCard extends StatelessWidget {
  final double currentWeight;
  final double change;
  final double targetWeight;
  final double startWeight;

  const WeightCard({
    super.key,
    required this.currentWeight,
    required this.change,
    required this.targetWeight,
    required this.startWeight,
  });

  @override
  Widget build(BuildContext context) {
    final isLoss = change <= 0;
    final totalRange = startWeight - targetWeight;
    final lost = startWeight - currentWeight;
    final progress = totalRange > 0 ? (lost / totalRange).clamp(0.0, 1.0) : 0.0;
    final remaining = currentWeight - targetWeight;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.mintGreen.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '今日体重',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              // 变化量标签
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isLoss
                      ? AppColors.mintGreen.withValues(alpha: 0.1)
                      : AppColors.warmOrangeLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isLoss ? Icons.arrow_downward : Icons.arrow_upward,
                      size: 14,
                      color: isLoss ? AppColors.mintGreen : AppColors.warmOrange,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${isLoss ? '' : '+'}${change.toStringAsFixed(1)} kg',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isLoss ? AppColors.mintGreen : AppColors.warmOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 大号体重数字
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                currentWeight.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.0,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'kg',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 进度条
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '起始 ${startWeight.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textDisabled,
                    ),
                  ),
                  Text(
                    '目标 ${targetWeight.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textDisabled,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: AppColors.mintGreen.withValues(alpha: 0.15),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.mintGreen),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                remaining > 0
                    ? '距目标还差 ${remaining.toStringAsFixed(1)} kg'
                    : '已达成目标！',
                style: TextStyle(
                  fontSize: 14,
                  color: remaining > 0
                      ? AppColors.textSecondary
                      : AppColors.mintGreen,
                  fontWeight: remaining <= 0 ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

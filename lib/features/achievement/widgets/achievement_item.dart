import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/achievements.dart';

class AchievementItem extends StatelessWidget {
  final AchievementDef achievement;
  final bool isUnlocked;
  final String? unlockedAt;

  const AchievementItem({
    super.key,
    required this.achievement,
    required this.isUnlocked,
    this.unlockedAt,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isUnlocked
        ? Color(achievement.color).withOpacity(0.12)
        : AppColors.textDisabled.withOpacity(0.08);

    final iconBgColor = isUnlocked
        ? Color(achievement.color).withOpacity(0.2)
        : AppColors.textDisabled.withOpacity(0.12);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnlocked ? AppColors.bgWhite : AppColors.bgWhite.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnlocked
              ? Color(achievement.color).withOpacity(0.2)
              : AppColors.textDisabled.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // 左侧 emoji 图标
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isUnlocked
                  ? Text(
                      achievement.icon,
                      style: const TextStyle(fontSize: 26),
                    )
                  : const Icon(
                      Icons.lock_outline,
                      size: 24,
                      color: AppColors.textDisabled,
                    ),
            ),
          ),
          const SizedBox(width: 14),
          // 右侧文字信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isUnlocked ? AppColors.textPrimary : AppColors.textDisabled,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isUnlocked ? achievement.description : '解锁条件：${achievement.description}',
                  style: TextStyle(
                    fontSize: 13,
                    color: isUnlocked ? AppColors.textSecondary : AppColors.textDisabled,
                  ),
                ),
                if (isUnlocked && unlockedAt != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 14,
                        color: Color(achievement.color),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '已解锁 · $unlockedAt',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(achievement.color),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          // 右侧状态指示
          if (isUnlocked)
            Icon(
              Icons.emoji_events,
              size: 20,
              color: Color(achievement.color),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slimup/core/theme/app_colors.dart';
import 'package:slimup/core/constants/achievements.dart';
import 'widgets/achievement_item.dart';

class AchievementPage extends ConsumerWidget {
  const AchievementPage({super.key});

  // 假数据：已解锁的成就类型
  static const Set<String> _unlockedTypes = {
    'first_checkin',
    'streak_7',
    'lost_1kg',
    'early_bird',
  };

  // 假数据：解锁时间
  static const Map<String, String> _unlockedAtMap = {
    'first_checkin': '2026-03-15',
    'streak_7': '2026-03-22',
    'lost_1kg': '2026-04-01',
    'early_bird': '2026-04-10',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allAchievements = AchievementDefs.all;
    final unlockedCount = allAchievements.where((a) => _unlockedTypes.contains(a.type)).length;
    final totalCount = allAchievements.length;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // 页面标题 + 统计
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  '成就',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                _buildProgressBadge(unlockedCount, totalCount),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // 进度条
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: unlockedCount / totalCount,
                          backgroundColor: AppColors.mintGreenLight.withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.mintGreen),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '$unlockedCount/$totalCount',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mintGreen,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 已解锁成就
          ..._buildSection(
            title: '已解锁',
            achievements: allAchievements.where((a) => _unlockedTypes.contains(a.type)).toList(),
            isUnlocked: true,
          ),

          if (unlockedCount > 0 && unlockedCount < totalCount)
            const SizedBox(height: 8),

          // 未解锁成就
          ..._buildSection(
            title: '未解锁',
            achievements: allAchievements.where((a) => !_unlockedTypes.contains(a.type)).toList(),
            isUnlocked: false,
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProgressBadge(int unlocked, int total) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.mintGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.emoji_events, size: 16, color: AppColors.mintGreen),
          const SizedBox(width: 4),
          Text(
            '$unlocked/$total',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.mintGreen,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSection({
    required String title,
    required List<AchievementDef> achievements,
    required bool isUnlocked,
  }) {
    if (achievements.isEmpty) return [];

    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ),
      ...achievements.map((a) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: AchievementItem(
              achievement: a,
              isUnlocked: isUnlocked,
              unlockedAt: _unlockedAtMap[a.type],
            ),
          )),
    ];
  }
}

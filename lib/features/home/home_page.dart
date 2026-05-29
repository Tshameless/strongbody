import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/motivations.dart';
import '../../routing/app_router.dart';
import 'widgets/weight_card.dart';
import 'widgets/stats_row.dart';
import 'widgets/motivation_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return '早上好';
    if (hour < 18) return '下午好';
    return '晚上好';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: 替换为真实数据
    const currentWeight = 72.5;
    const change = -0.3;
    const targetWeight = 65.0;
    const startWeight = 80.0;
    const streak = 7;
    const achievements = 3;
    const totalLoss = 7.5;

    final motivation = Motivations.getDaily();
    final currentIndex = navItems.indexWhere(
      (item) => item.path == '/',
    );

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 顶部问候语
              Text(
                _greeting(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '今天也要加油哦',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              // 体重主卡片
              WeightCard(
                currentWeight: currentWeight,
                change: change,
                targetWeight: targetWeight,
                startWeight: startWeight,
              ),
              const SizedBox(height: 20),

              // 三宫格统计
              StatsRow(
                streak: streak,
                achievements: achievements,
                totalLoss: totalLoss,
              ),
              const SizedBox(height: 20),

              // 每日激励语
              MotivationCard(item: motivation),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          context.go(navItems[index].path);
        },
        backgroundColor: AppColors.bgWhite,
        indicatorColor: AppColors.mintGreen.withValues(alpha: 0.12),
        destinations: navItems.map((item) {
          return NavigationDestination(
            icon: Icon(item.icon),
            selectedIcon: Icon(item.activeIcon),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }
}

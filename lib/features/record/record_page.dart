import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slimup/core/theme/app_colors.dart';
import 'package:slimup/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'widgets/weight_slider.dart';

// 选中的日期
final _selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

// 选中的体重
final _selectedWeightProvider = StateProvider<double>((ref) => 65.0);

// 备注内容
final _noteProvider = StateProvider<String>((ref) => '');

class RecordPage extends ConsumerWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(_selectedDateProvider);
    final selectedWeight = ref.watch(_selectedWeightProvider);
    final note = ref.watch(_noteProvider);
    final currentIndex = navItems.indexWhere((item) => item.path == '/record');

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('记录体重'),
        centerTitle: true,
        backgroundColor: AppColors.bgWhite,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 日期选择器
              _DateSelector(
                selectedDate: selectedDate,
                onDateSelected: (date) {
                  ref.read(_selectedDateProvider.notifier).state = date;
                },
              ),
              const SizedBox(height: 28),

              // 大号体重显示
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      selectedWeight.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'kg',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // 体重滑块
              WeightSlider(
                value: selectedWeight,
                onChanged: (value) {
                  ref.read(_selectedWeightProvider.notifier).state = value;
                },
              ),
              const SizedBox(height: 28),

              // 备注输入框
              const Text(
                '备注',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                maxLines: 3,
                maxLength: 200,
                onChanged: (value) {
                  ref.read(_noteProvider.notifier).state = value;
                },
                decoration: InputDecoration(
                  hintText: '今天有什么感受？',
                  hintStyle: const TextStyle(color: AppColors.textDisabled),
                  filled: true,
                  fillColor: AppColors.bgWhite,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 32),

              // 保存按钮
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: () {
                    // TODO: 保存到数据库
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '已记录 ${selectedWeight.toStringAsFixed(1)} kg',
                        ),
                        backgroundColor: AppColors.mintGreen,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.mintGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    '保存记录',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
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
        indicatorColor: AppColors.mintGreen.withOpacity(0.12),
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

class _DateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const _DateSelector({
    required this.selectedDate,
    required this.onDateSelected,
  });

  String _formatDate(DateTime date) {
    return '${date.year}年${date.month}月${date.day}日';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2024, 1, 1),
          lastDate: DateTime.now(),
          locale: const Locale('zh', 'CN'),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: AppColors.mintGreen,
                    ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.bgWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today,
              size: 20,
              color: AppColors.mintGreen,
            ),
            const SizedBox(width: 10),
            Text(
              _formatDate(selectedDate),
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textDisabled,
            ),
          ],
        ),
      ),
    );
  }
}

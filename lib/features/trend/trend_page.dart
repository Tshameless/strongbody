import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../core/theme/app_colors.dart';
import 'widgets/weight_chart.dart';

class TrendPage extends ConsumerStatefulWidget {
  const TrendPage({super.key});

  @override
  ConsumerState<TrendPage> createState() => _TrendPageState();
}

class _TrendPageState extends ConsumerState<TrendPage> {
  String _selectedPeriod = '7天';
  final List<String> _periods = ['7天', '30天', '全部'];

  // 假数据
  final List<double> _weightData7 = [65.0, 64.8, 64.5, 64.7, 64.3, 64.1, 63.8];
  final double _currentWeight = 63.8;
  final double _height = 170.0; // cm

  // 打卡日期假数据
  final Set<DateTime> _checkinDays = {
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now().subtract(const Duration(days: 2)),
    DateTime.now().subtract(const Duration(days: 3)),
    DateTime.now().subtract(const Duration(days: 5)),
    DateTime.now().subtract(const Duration(days: 6)),
    DateTime.now().subtract(const Duration(days: 8)),
    DateTime.now().subtract(const Duration(days: 9)),
    DateTime.now().subtract(const Duration(days: 10)),
  };

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  double get _bmi => _currentWeight / ((_height / 100) * (_height / 100));

  String get _bmiLabel {
    if (_bmi < 18.5) return '偏瘦';
    if (_bmi < 24) return '正常';
    if (_bmi < 28) return '偏胖';
    return '肥胖';
  }

  Color get _bmiColor {
    if (_bmi < 18.5) return AppColors.skyBlue;
    if (_bmi < 24) return AppColors.mintGreen;
    if (_bmi < 28) return AppColors.warmOrange;
    return Colors.red;
  }

  List<FlSpot> get _chartData {
    return List.generate(_weightData7.length, (i) => FlSpot(i.toDouble(), _weightData7[i]));
  }

  List<String> get _dateLabels {
    final now = DateTime.now();
    return List.generate(_weightData7.length, (i) {
      final date = now.subtract(Duration(days: _weightData7.length - 1 - i));
      return '${date.month}/${date.day}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // 顶部时间段切换
          _buildPeriodSwitcher(),
          const SizedBox(height: 16),

          // 体重折线图卡片
          _buildWeightChartCard(),
          const SizedBox(height: 16),

          // BMI卡片
          _buildBmiCard(),
          const SizedBox(height: 16),

          // 打卡日历
          _buildCalendarCard(),
        ],
      ),
    );
  }

  Widget _buildPeriodSwitcher() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.bgWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.mintGreenLight.withOpacity(0.3)),
        ),
        child: Row(
          children: _periods.map((period) {
            final isSelected = period == _selectedPeriod;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedPeriod = period),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.mintGreen : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    period,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildWeightChartCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: WeightChart(
        data: _chartData,
        periodLabel: _selectedPeriod,
        dateLabels: _dateLabels,
      ),
    );
  }

  Widget _buildBmiCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // BMI数值
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'BMI 指数',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    _bmi.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: _bmiColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _bmiColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _bmiLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _bmiColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          // 身高体重信息
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildInfoRow('体重', '$_currentWeight kg'),
              const SizedBox(height: 6),
              _buildInfoRow('身高', '$_height cm'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '打卡日历',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          TableCalendar(
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now(),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            availableCalendarFormats: const {
              CalendarFormat.month: '月',
              CalendarFormat.twoWeeks: '两周',
              CalendarFormat.week: '周',
            },
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() => _calendarFormat = format);
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColors.mintGreenLight.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: AppColors.mintGreen,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
              weekendTextStyle: const TextStyle(fontSize: 13, color: AppColors.warmOrange),
              outsideTextStyle: TextStyle(fontSize: 13, color: AppColors.textDisabled.withOpacity(0.5)),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                final isCheckin = _checkinDays.any(
                  (d) => d.year == day.year && d.month == day.month && d.day == day.day,
                );
                if (isCheckin) {
                  return Positioned(
                    bottom: 2,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.mintGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
            headerStyle: const HeaderStyle(
              formatButtonTextStyle: TextStyle(fontSize: 12, color: AppColors.mintGreen),
              formatButtonDecoration: BoxDecoration(
                border: Border.fromBorderSide(BorderSide(color: AppColors.mintGreenLight, width: 1)),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              titleTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              leftChevronIcon: Icon(Icons.chevron_left, color: AppColors.mintGreen),
              rightChevronIcon: Icon(Icons.chevron_right, color: AppColors.mintGreen),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              weekendStyle: TextStyle(fontSize: 12, color: AppColors.warmOrangeLight),
            ),
            locale: 'zh_CN',
          ),
        ],
      ),
    );
  }
}

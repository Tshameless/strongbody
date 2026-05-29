import 'package:flutter/material.dart';

/// 日期格式化工具类
class DateFormatter {
  DateFormatter._();

  /// 格式化完整日期 - "2024年1月15日"
  static String formatDate(DateTime date) {
    return '${date.year}年${date.month}月${date.day}日';
  }

  /// 格式化短日期 - "1月15日"
  static String formatShortDate(DateTime date) {
    return '${date.month}月${date.day}日';
  }

  /// 根据当前时间返回问候语
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 0 && hour < 12) return '早啊';
    if (hour >= 12 && hour < 18) return '下午好';
    return '晚上好';
  }

  /// 格式化体重 - "62.5"
  static String formatWeight(double weight) {
    return weight.toStringAsFixed(1);
  }
}

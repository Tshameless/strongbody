import 'package:flutter/material.dart';

/// BMI计算工具类
class BmiCalculator {
  BmiCalculator._();

  /// 计算BMI值
  /// weightKg: 体重(kg), heightCm: 身高(cm)
  static double calculate(double weightKg, double heightCm) {
    if (heightCm <= 0) return 0;
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  /// 获取BMI状态描述
  static String getStatus(double bmi) {
    if (bmi < 18.5) return '偏瘦';
    if (bmi < 24) return '正常';
    if (bmi < 28) return '偏胖';
    return '肥胖';
  }

  /// 获取BMI状态对应颜色
  static Color getStatusColor(double bmi) {
    if (bmi < 18.5) return const Color(0xFF29B6F6); // skyBlue
    if (bmi < 24) return const Color(0xFF4CAF50); // mintGreen - 正常
    if (bmi < 28) return const Color(0xFFFF9800); // warmOrange
    return const Color(0xFFE53935); // 红色 - 肥胖
  }
}

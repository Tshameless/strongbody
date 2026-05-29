import 'package:flutter/material.dart';

// ========== 亮色模式颜色 ==========
class AppColors {
  AppColors._();

  // 主色
  static const Color mintGreen = Color(0xFF4CAF50);
  static const Color mintGreenLight = Color(0xFF81C784);
  static const Color mintGreenDark = Color(0xFF2E7D32);

  // 辅色
  static const Color warmOrange = Color(0xFFFF9800);
  static const Color warmOrangeLight = Color(0xFFFFE0B2);

  // 功能色
  static const Color skyBlue = Color(0xFF29B6F6);
  static const Color lemonYellow = Color(0xFFFDD835);

  // 背景
  static const Color bgLight = Color(0xFFF5F9F5);
  static const Color bgWhite = Color(0xFFFFFFFF);

  // 文字
  static const Color textPrimary = Color(0xFF1B3A1B);
  static const Color textSecondary = Color(0xFF6B8E6B);
  static const Color textDisabled = Color(0xFFA5C4A5);

  // 渐变
  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [mintGreenLight, mintGreen],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [bgWhite, Color(0xFFF0F7F0)],
  );
}

// ========== 暗色模式颜色 ==========
class AppColorsDark {
  AppColorsDark._();

  static const Color bg = Color(0xFF1A2E1A);
  static const Color card = Color(0xFF243824);
  static const Color mintGreen = Color(0xFF66BB6A);
  static const Color warmOrange = Color(0xFFFFB74D);
  static const Color textPrimary = Color(0xFFE8F5E9);
  static const Color textSecondary = Color(0xFFA5C4A5);
}

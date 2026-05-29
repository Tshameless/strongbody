import 'package:flutter/material.dart';

/// 设置项Widget - 左侧图标+文字，右侧箭头或自定义widget
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? const Color(0xFF4CAF50),
        size: 24,
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF1B3A1B),
        ),
      ),
      trailing: trailing ??
          const Icon(
            Icons.chevron_right,
            color: Color(0xFFA5C4A5),
            size: 22,
          ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: 24,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/home/home_page.dart';
import '../features/record/record_page.dart';
import '../features/trend/trend_page.dart';
import '../features/achievement/achievement_page.dart';
import '../features/profile/profile_page.dart';
import '../features/auth/login_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/record',
        builder: (context, state) => const RecordPage(),
      ),
      GoRoute(
        path: '/trend',
        builder: (context, state) => const TrendPage(),
      ),
      GoRoute(
        path: '/achievement',
        builder: (context, state) => const AchievementPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
});

// 底部导航项
class NavItem {
  final String path;
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const NavItem({
    required this.path,
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}

const List<NavItem> navItems = [
  NavItem(
    path: '/',
    label: '首页',
    icon: Icons.eco_outlined,
    activeIcon: Icons.eco,
  ),
  NavItem(
    path: '/record',
    label: '记录',
    icon: Icons.edit_outlined,
    activeIcon: Icons.edit,
  ),
  NavItem(
    path: '/trend',
    label: '趋势',
    icon: Icons.show_chart_outlined,
    activeIcon: Icons.show_chart,
  ),
  NavItem(
    path: '/achievement',
    label: '成就',
    icon: Icons.emoji_events_outlined,
    activeIcon: Icons.emoji_events,
  ),
  NavItem(
    path: '/profile',
    label: '我的',
    icon: Icons.person_outline,
    activeIcon: Icons.person,
  ),
];

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import 'widgets/profile_menu_item.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          const SizedBox(height: 12),
          // 用户信息卡片
          _buildUserCard(context),
          const SizedBox(height: 20),
          // 设置分组
          _buildSectionTitle('个人信息'),
          _buildCard([
            ProfileMenuItem(
              icon: Icons.person_outline,
              label: '昵称',
              trailing: Text(
                '小薄荷',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              onTap: () {},
            ),
            const _Divider(),
            ProfileMenuItem(
              icon: Icons.height,
              label: '身高',
              trailing: Text(
                '165 cm',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              onTap: () {},
            ),
            const _Divider(),
            ProfileMenuItem(
              icon: Icons.track_changes,
              label: '目标体重',
              trailing: Text(
                '55.0 kg',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 20),
          _buildSectionTitle('偏好设置'),
          _buildCard([
            ProfileMenuItem(
              icon: Icons.notifications_outlined,
              label: '每日提醒',
              trailing: Text(
                '08:00',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              onTap: () {},
            ),
            const _Divider(),
            ProfileMenuItem(
              icon: Icons.dark_mode_outlined,
              label: '深色模式',
              trailing: Switch(
                value: false,
                onChanged: (val) {},
                activeColor: AppColors.mintGreen,
              ),
              onTap: null,
            ),
          ]),
          const SizedBox(height: 20),
          _buildSectionTitle('数据'),
          _buildCard([
            ProfileMenuItem(
              icon: Icons.cloud_outlined,
              label: '云同步',
              trailing: Text(
                '未登录',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textDisabled,
                ),
              ),
              onTap: () {},
            ),
            const _Divider(),
            ProfileMenuItem(
              icon: Icons.file_download_outlined,
              label: '数据导出',
              trailing: Text(
                'JSON',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 20),
          _buildCard([
            ProfileMenuItem(
              icon: Icons.info_outline,
              label: '关于',
              onTap: () {},
            ),
            const _Divider(),
            ProfileMenuItem(
              icon: Icons.tag,
              label: '版本号',
              trailing: Text(
                'v1.0.0',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textDisabled,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// 用户信息卡片
  Widget _buildUserCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.greenGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.mintGreen.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // 头像
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.3),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.6),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person,
              size: 36,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '小薄荷',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '已坚持 28 天',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  /// 分组标题
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  /// 卡片容器
  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.mintGreen.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

/// 分隔线
class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        thickness: 0.5,
        color: Color(0xFFF0F7F0),
      ),
    );
  }
}

// 成就定义常量
class AchievementDefs {
  AchievementDefs._();

  static const List<AchievementDef> all = [
    AchievementDef(
      type: 'first_checkin',
      title: '初次打卡',
      description: '记录第一次体重',
      icon: '🌱',
      color: 0xFF81C784,
    ),
    AchievementDef(
      type: 'streak_7',
      title: '坚持7天',
      description: '连续打卡7天',
      icon: '🌿',
      color: 0xFF4CAF50,
    ),
    AchievementDef(
      type: 'streak_30',
      title: '坚持30天',
      description: '连续打卡30天',
      icon: '🌳',
      color: 0xFF2E7D32,
    ),
    AchievementDef(
      type: 'streak_100',
      title: '坚持100天',
      description: '连续打卡100天',
      icon: '🏔️',
      color: 0xFF1B5E20,
    ),
    AchievementDef(
      type: 'lost_1kg',
      title: '第一个1kg',
      description: '累计减重1kg',
      icon: '🍃',
      color: 0xFFA5D6A7,
    ),
    AchievementDef(
      type: 'lost_5kg',
      title: '第一个5kg',
      description: '累计减重5kg',
      icon: '🌺',
      color: 0xFFFF9800,
    ),
    AchievementDef(
      type: 'goal_reached',
      title: '达成目标',
      description: '体重达到目标体重',
      icon: '🍀',
      color: 0xFF00C853,
    ),
    AchievementDef(
      type: 'bmi_normal',
      title: 'BMI正常',
      description: 'BMI回到18.5-24范围',
      icon: '☀️',
      color: 0xFF29B6F6,
    ),
    AchievementDef(
      type: 'data_master',
      title: '数据达人',
      description: '累计记录100次',
      icon: '📊',
      color: 0xFF4CAF50,
    ),
    AchievementDef(
      type: 'early_bird',
      title: '早起打卡',
      description: '在早上8点前记录',
      icon: '🌅',
      color: 0xFFFFB74D,
    ),
  ];

  static AchievementDef? getByType(String type) {
    try {
      return all.firstWhere((a) => a.type == type);
    } catch (e) {
      return null;
    }
  }
}

class AchievementDef {
  final String type;
  final String title;
  final String description;
  final String icon;
  final int color;

  const AchievementDef({
    required this.type,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

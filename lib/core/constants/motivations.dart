// 激励语句常量
class Motivations {
  Motivations._();

  static const List<MotivationItem> all = [
    // 坚持
    MotivationItem(content: '每一步都算数', category: 'persist'),
    MotivationItem(content: '坚持本身就是了不起的事', category: 'persist'),
    MotivationItem(content: '慢慢来，比较快', category: 'persist'),
    MotivationItem(content: '你已经走在路上了', category: 'persist'),
    MotivationItem(content: '今天的选择，是明天的答案', category: 'persist'),
    MotivationItem(content: '不急不躁，时间会给你答案', category: 'persist'),
    MotivationItem(content: '每一天都是新的开始', category: 'persist'),
    MotivationItem(content: '坚持不是因为容易，而是因为值得', category: 'persist'),
    MotivationItem(content: '你在做的，是未来的自己会感谢的事', category: 'persist'),
    MotivationItem(content: '没有白走的路，每一步都算', category: 'persist'),
    MotivationItem(content: '种一棵树最好的时间是十年前，其次是现在', category: 'persist'),
    MotivationItem(content: '雨后总会有彩虹', category: 'persist'),
    MotivationItem(content: '日拱一卒，功不唐捐', category: 'persist'),
    MotivationItem(content: '不怕慢，就怕站', category: 'persist'),
    MotivationItem(content: '星光不问赶路人', category: 'persist'),

    // 减重
    MotivationItem(content: '今天的你比昨天轻了一点点', category: 'weight'),
    MotivationItem(content: '身体正在感谢你', category: 'weight'),
    MotivationItem(content: '绿色代表生长，你也一样', category: 'weight'),
    MotivationItem(content: '减重不是惩罚，是给自己的礼物', category: 'weight'),
    MotivationItem(content: '每减一克，都是对自己的温柔', category: 'weight'),
    MotivationItem(content: '轻盈是一种自由', category: 'weight'),
    MotivationItem(content: '你的身体比你想象得更听话', category: 'weight'),
    MotivationItem(content: '距离目标又近了一步', category: 'weight'),
    MotivationItem(content: '数字在变小，你在变好', category: 'weight'),
    MotivationItem(content: '量变终会引起质变', category: 'weight'),

    // 心态
    MotivationItem(content: '你已经很棒了', category: 'mindset'),
    MotivationItem(content: '和自己比，就够了', category: 'mindset'),
    MotivationItem(content: '接纳此刻的自己', category: 'mindset'),
    MotivationItem(content: '别和体重秤较劲，和生活和解', category: 'mindset'),
    MotivationItem(content: '你值得被温柔以待', category: 'mindset'),
    MotivationItem(content: '关注过程，结果不会辜负你', category: 'mindset'),
    MotivationItem(content: '偶尔懈怠也没关系，继续就好', category: 'mindset'),
    MotivationItem(content: '你已经迈出了最难的第一步', category: 'mindset'),
    MotivationItem(content: '善待自己，是减重最好的方式', category: 'mindset'),
    MotivationItem(content: '不完美也值得被爱', category: 'mindset'),
  ];

  static MotivationItem getDaily() {
    final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    return all[dayOfYear % all.length];
  }

  static MotivationItem getRandom() {
    return all[DateTime.now().millisecond % all.length];
  }
}

class MotivationItem {
  final String content;
  final String category;

  const MotivationItem({required this.content, required this.category});
}

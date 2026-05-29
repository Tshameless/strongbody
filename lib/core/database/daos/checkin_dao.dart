import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../app_database.dart';
import '../tables.dart';

part 'checkin_dao.g.dart';

@DriftAccessor(tables: [Checkins])
class CheckinDao extends DatabaseAccessor<AppDatabase>
    with _$CheckinDaoMixin {
  CheckinDao(super.db);

  final _uuid = const Uuid();

  // 查询连续打卡天数
  Future<int> getStreak(String userId) async {
    final records = await (select(checkins)
          ..where((t) => t.userId.equals(userId) & t.type.equals(1))
          ..orderBy([(t) => OrderingTerm.desc(t.checkinDate)]))
        .get();

    if (records.isEmpty) return 0;

    int streak = 0;
    DateTime? lastDate;

    for (final record in records) {
      final date = DateTime(
        record.checkinDate.year,
        record.checkinDate.month,
        record.checkinDate.day,
      );

      if (lastDate == null) {
        // 第一条记录：检查是否是今天或昨天
        final today = DateTime.now();
        final todayDate = DateTime(today.year, today.month, today.day);
        final yesterdayDate = todayDate.subtract(const Duration(days: 1));

        if (date == todayDate || date == yesterdayDate) {
          streak = 1;
          lastDate = date;
        } else {
          break;
        }
      } else {
        final expectedDate = lastDate!.subtract(const Duration(days: 1));
        if (date == expectedDate) {
          streak++;
          lastDate = date;
        } else {
          break;
        }
      }
    }

    return streak;
  }

  // 今日是否已打卡
  Future<bool> hasCheckedInToday(String userId) async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));

    final record = await (select(checkins)
          ..where((t) =>
              t.userId.equals(userId) &
              t.type.equals(1) &
              t.checkinDate.isBiggerOrEqualValue(start) &
              t.checkinDate.isSmallerThanValue(end)))
        .getSingleOrNull();

    return record != null;
  }

  // 打卡
  Future<void> checkin({
    required String userId,
    required DateTime date,
    int type = 1,
  }) {
    return into(checkins).insert(CheckinsCompanion.insert(
      id: _uuid.v4(),
      userId: userId,
      checkinDate: date,
      type: Value(type),
      synced: const Value(false),
      createdAt: Value(DateTime.now()),
    ));
  }

  // 查询打卡日历数据（某月）
  Future<List<Checkin>> getMonthCheckins(String userId, int year, int month) {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 1);

    return (select(checkins)
          ..where((t) =>
              t.userId.equals(userId) &
              t.type.equals(1) &
              t.checkinDate.isBiggerOrEqualValue(start) &
              t.checkinDate.isSmallerThanValue(end)))
        .get();
  }
}

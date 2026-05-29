import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../app_database.dart';
import '../tables.dart';

part 'achievement_dao.g.dart';

@DriftAccessor(tables: [Achievements])
class AchievementDao extends DatabaseAccessor<AppDatabase>
    with _$AchievementDaoMixin {
  AchievementDao(super.db);

  final _uuid = const Uuid();

  // 查询所有已解锁成就
  Future<List<Achievement>> getAll(String userId) {
    return (select(achievements)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.unlockedAt)]))
        .get();
  }

  // 查询某个成就是否已解锁
  Future<bool> isUnlocked(String userId, String type) async {
    final record = await (select(achievements)
          ..where((t) => t.userId.equals(userId) & t.type.equals(type)))
        .getSingleOrNull();
    return record != null;
  }

  // 解锁成就
  Future<void> unlock({
    required String userId,
    required String type,
  }) {
    return into(achievements).insert(AchievementsCompanion.insert(
      id: _uuid.v4(),
      userId: userId,
      type: type,
      unlockedAt: Value(DateTime.now()),
      synced: const Value(false),
    ));
  }

  // 查询未同步的成就
  Future<List<Achievement>> getUnsynced(String userId) {
    return (select(achievements)
          ..where((t) => t.userId.equals(userId) & t.synced.equals(false)))
        .get();
  }
}

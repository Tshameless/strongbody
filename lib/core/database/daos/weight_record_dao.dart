import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../app_database.dart';
import '../tables.dart';

part 'weight_record_dao.g.dart';

@DriftAccessor(tables: [WeightRecords])
class WeightRecordDao extends DatabaseAccessor<AppDatabase>
    with _$WeightRecordDaoMixin {
  WeightRecordDao(super.db);

  final _uuid = const Uuid();

  // 查询全部记录（按日期倒序）
  Future<List<WeightRecord>> getAll(String userId) {
    return (select(weightRecords)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.recordDate)]))
        .get();
  }

  // 查询最近一条记录
  Future<WeightRecord?> getLatest(String userId) {
    return (select(weightRecords)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.recordDate)])
          ..limit(1))
        .getSingleOrNull();
  }

  // 按日期范围查询
  Future<List<WeightRecord>> getByDateRange(
    String userId,
    DateTime start,
    DateTime end,
  ) {
    return (select(weightRecords)
          ..where((t) =>
              t.userId.equals(userId) &
              t.recordDate.isBiggerOrEqualValue(start) &
              t.recordDate.isSmallerOrEqualValue(end))
          ..orderBy([(t) => OrderingTerm.asc(t.recordDate)]))
        .get();
  }

  // 查询某天的记录
  Future<WeightRecord?> getByDate(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(weightRecords)
          ..where((t) =>
              t.userId.equals(userId) &
              t.recordDate.isBiggerOrEqualValue(start) &
              t.recordDate.isSmallerThanValue(end)))
        .getSingleOrNull();
  }

  // 查询最近N天记录
  Future<List<WeightRecord>> getRecent(String userId, int days) {
    final start = DateTime.now().subtract(Duration(days: days));
    return getByDateRange(userId, start, DateTime.now());
  }

  // 查询未同步的记录
  Future<List<WeightRecord>> getUnsynced(String userId) {
    return (select(weightRecords)
          ..where((t) => t.userId.equals(userId) & t.synced.equals(false)))
        .get();
  }

  // 插入记录
  Future<void> insertRecord({
    required String userId,
    required double weight,
    required DateTime recordDate,
    String? note,
  }) {
    return into(weightRecords).insert(WeightRecordsCompanion.insert(
      id: _uuid.v4(),
      userId: userId,
      weight: weight,
      recordDate: recordDate,
      note: Value(note),
      synced: const Value(false),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    ));
  }

  // 更新记录
  Future<void> updateRecord(WeightRecord record) {
    return (update(weightRecords)).replace(WeightRecordsCompanion(
      id: Value(record.id),
      userId: Value(record.userId),
      weight: Value(record.weight),
      recordDate: Value(record.recordDate),
      note: Value(record.note),
      synced: const Value(false),
      createdAt: Value(record.createdAt),
      updatedAt: Value(DateTime.now()),
    ));
  }

  // 删除记录
  Future<void> deleteRecord(String id) {
    return (delete(weightRecords)..where((t) => t.id.equals(id))).go();
  }

  // 标记为已同步
  Future<void> markSynced(String id) {
    return (update(weightRecords)..where((t) => t.id.equals(id))).write(
      const WeightRecordsCompanion(synced: Value(true)),
    );
  }

  // 统计记录总数
  Future<int> getCount(String userId) async {
    final records = await getAll(userId);
    return records.length;
  }

  // 计算总减重量（相对第一条记录）
  Future<double> getTotalLoss(String userId) async {
    final records = await (select(weightRecords)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.asc(t.recordDate)]))
        .get();
    if (records.length < 2) return 0;
    final first = records.first.weight;
    final latest = records.last.weight;
    return first - latest; // 正数=减了，负数=增了
  }
}

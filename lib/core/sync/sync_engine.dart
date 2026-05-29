import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../database/daos/weight_record_dao.dart';
import '../database/daos/achievement_dao.dart';
import '../network/supabase_client.dart';

// 网络连接状态
final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  return Connectivity().onConnectivityChanged;
});

// 同步状态
enum SyncStatus { idle, syncing, success, error }

final syncStatusProvider = StateProvider<SyncStatus>((ref) => SyncStatus.idle);

// 同步引擎
class SyncEngine {
  final AppDatabase _db;
  final Ref _ref;

  SyncEngine(this._db, this._ref);

  Timer? _syncTimer;

  // 启动自动同步（每5分钟检查一次）
  void startAutoSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      sync();
    });
  }

  // 停止自动同步
  void stopAutoSync() {
    _syncTimer?.cancel();
  }

  // 执行同步
  Future<void> sync() async {
    final connectivity = _ref.read(connectivityProvider).valueOrNull;
    if (connectivity == ConnectivityResult.none) return;
    if (!SupabaseClient.isAuthenticated) return;

    _ref.read(syncStatusProvider.notifier).state = SyncStatus.syncing;

    try {
      // 1. 上传未同步的体重记录
      final weightDao = WeightRecordDao(_db);
      final unsyncedWeights = await weightDao.getUnsynced(
        SupabaseClient.currentUser!.id,
      );

      for (final record in unsyncedWeights) {
        await SupabaseClient.upsertWeightRecord({
          'id': record.id,
          'user_id': record.userId,
          'weight': record.weight,
          'record_date': record.recordDate.toIso8601String(),
          'note': record.note,
          'created_at': record.createdAt.toIso8601String(),
          'updated_at': record.updatedAt.toIso8601String(),
        });
        await weightDao.markSynced(record.id);
      }

      // 2. 上传未同步的成就
      final achievementDao = AchievementDao(_db);
      final unsyncedAchievements = await achievementDao.getUnsynced(
        SupabaseClient.currentUser!.id,
      );

      for (final achievement in unsyncedAchievements) {
        await SupabaseClient.upsertAchievement({
          'id': achievement.id,
          'user_id': achievement.userId,
          'type': achievement.type,
          'unlocked_at': achievement.unlockedAt.toIso8601String(),
        });
        // 标记已同步
      }

      _ref.read(syncStatusProvider.notifier).state = SyncStatus.success;
    } catch (e) {
      _ref.read(syncStatusProvider.notifier).state = SyncStatus.error;
    }
  }

  // 从云端恢复数据（换手机时）
  Future<void> restoreFromCloud() async {
    if (!SupabaseClient.isAuthenticated) return;

    // 下载体重记录
    final remoteWeights = await SupabaseClient.downloadWeightRecords();
    final weightDao = WeightRecordDao(_db);

    for (final record in remoteWeights) {
      await weightDao.insertRecord(
        userId: record['user_id'],
        weight: (record['weight'] as num).toDouble(),
        recordDate: DateTime.parse(record['record_date']),
        note: record['note'],
      );
    }

    // 下载成就
    final remoteAchievements = await SupabaseClient.downloadAchievements();
    final achievementDao = AchievementDao(_db);

    for (final achievement in remoteAchievements) {
      final isUnlocked = await achievementDao.isUnlocked(
        achievement['user_id'],
        achievement['type'],
      );
      if (!isUnlocked) {
        await achievementDao.unlock(
          userId: achievement['user_id'],
          type: achievement['type'],
        );
      }
    }
  }
}

// 同步引擎 Provider
final syncEngineProvider = Provider<SyncEngine>((ref) {
  final db = AppDatabase();
  final engine = SyncEngine(db, ref);
  ref.onDispose(() => engine.stopAutoSync());
  return engine;
});

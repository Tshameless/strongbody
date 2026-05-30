import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Users,
  WeightRecords,
  Checkins,
  Achievements,
  MotivationRecords,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      // 插入默认用户
      await into(users).insert(UsersCompanion.insert(
        id: const Uuid().v4(),
        nickname: const Value('我'),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ));
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'slimup.db'));
    return NativeDatabase.createInBackground(file);
  });
}

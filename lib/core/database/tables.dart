import 'package:drift/drift.dart';

// 用户表
class Users extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get email => text().nullable()();
  TextColumn get nickname => text().withDefault(const Value('我'))();
  TextColumn get avatarUrl => text().nullable()();
  RealColumn get height => real().nullable()(); // 身高cm
  RealColumn get targetWeight => real().nullable()(); // 目标体重kg
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// 体重记录表
class WeightRecords extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  RealColumn get weight => real()(); // 体重kg
  DateTimeColumn get recordDate => dateTime()(); // 记录日期
  TextColumn get note => text().nullable()(); // 备注
  BoolColumn get synced => boolean().withDefault(const Value(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// 打卡记录表
class Checkins extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  DateTimeColumn get checkinDate => dateTime()();
  IntColumn get type => integer().withDefault(const Value(1))(); // 1:体重 2:饮食 3:运动
  BoolColumn get synced => boolean().withDefault(const Value(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// 成就表
class Achievements extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get type => text()(); // 成就类型标识
  DateTimeColumn get unlockedAt => dateTime()();
  BoolColumn get synced => boolean().withDefault(const Value(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// 激励语句表（仅本地）
class MotivationRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
  TextColumn get category => text()(); // persist/weight/mindset
}

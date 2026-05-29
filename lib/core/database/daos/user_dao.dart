import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../app_database.dart';
import '../tables.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  final _uuid = const Uuid();

  // 获取当前用户（单用户模式，取第一个）
  Future<User?> getCurrentUser() async {
    final users = await select(users).get();
    return users.isNotEmpty ? users.first : null;
  }

  // 创建用户
  Future<String> createUser({
    String? nickname,
    double? height,
    double? targetWeight,
  }) async {
    final id = _uuid.v4();
    await into(users).insert(UsersCompanion.insert(
      id: id,
      nickname: Value(nickname ?? '我'),
      height: Value(height),
      targetWeight: Value(targetWeight),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    ));
    return id;
  }

  // 更新用户信息
  Future<void> updateUser({
    required String id,
    String? nickname,
    String? avatarUrl,
    double? height,
    double? targetWeight,
  }) async {
    final user = await (select(users)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (user == null) return;

    await (update(users)).replace(UsersCompanion(
      id: Value(id),
      email: Value(user.email),
      nickname: Value(nickname ?? user.nickname),
      avatarUrl: Value(avatarUrl ?? user.avatarUrl),
      height: Value(height ?? user.height),
      targetWeight: Value(targetWeight ?? user.targetWeight),
      createdAt: Value(user.createdAt),
      updatedAt: Value(DateTime.now()),
    ));
  }

  // 获取用户ID（不存在则创建）
  Future<String> ensureUserId() async {
    final user = await getCurrentUser();
    if (user != null) return user.id;
    return createUser();
  }
}

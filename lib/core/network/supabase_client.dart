import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClient {
  SupabaseClient._();

  static const String _supabaseUrl = 'https://your-project.supabase.co';
  static const String _supabaseAnonKey = 'your-anon-key';

  static Supabase get client => Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: _supabaseUrl,
      anonKey: _supabaseAnonKey,
    );
  }

  // ========== 用户认证 ==========

  static Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return client.auth.signUp(
      email: email,
      password: password,
    );
  }

  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  static User? get currentUser => client.auth.currentUser;

  static bool get isAuthenticated => currentUser != null;

  // ========== 数据操作 ==========

  // 上传体重记录
  static Future<void> upsertWeightRecord(Map<String, dynamic> record) async {
    if (!isAuthenticated) return;
    await client.from('weight_records').upsert(record);
  }

  // 下载全部体重记录（换手机恢复用）
  static Future<List<Map<String, dynamic>>> downloadWeightRecords() async {
    if (!isAuthenticated) return [];
    final response = await client
        .from('weight_records')
        .select()
        .eq('user_id', currentUser!.id)
        .order('record_date');
    return List<Map<String, dynamic>>.from(response);
  }

  // 上传成就
  static Future<void> upsertAchievement(Map<String, dynamic> achievement) async {
    if (!isAuthenticated) return;
    await client.from('achievements').upsert(achievement);
  }

  // 下载全部成就
  static Future<List<Map<String, dynamic>>> downloadAchievements() async {
    if (!isAuthenticated) return [];
    final response = await client
        .from('achievements')
        .select()
        .eq('user_id', currentUser!.id);
    return List<Map<String, dynamic>>.from(response);
  }
}

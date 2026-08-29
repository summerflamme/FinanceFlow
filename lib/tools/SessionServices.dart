import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _userIdKey = 'user_id';

  Future<void> saveUser(int userId) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(_userIdKey, userId);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(_userIdKey);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_userIdKey);
  }

  Future<bool> isLoggedIn() async {
    final userId = await getUserId();

    return userId != null;
  }
}

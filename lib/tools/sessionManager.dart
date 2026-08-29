class SessionManager {
  static int? _userId;

  static int? get userId => _userId;

  static bool get isLoggedIn => _userId != null;

  static void login(int userId) {
    _userId = userId;
  }

  static void logout() {
    _userId = null;
  }
}

import 'package:financeflow/datasource/user_datasource.dart';
import 'package:password_guard/password_guard.dart';

import '../models/user.dart';

class UserRepository {
  final UserDatasource datasource;
  UserRepository(this.datasource);

  Future<int> addUser(User user) async {
    return await datasource.insertUser(user);
  }

  Future<User?> login(String username, String password) async {
    final user = await datasource.findByUsername(username);

    if (user == null) {
      return null;
    }

    final validPassword = await PasswordGuard.verify(
      password: password,
      hash: user.password,
    );

    if (!validPassword) {
      return null;
    }

    return user;
  }
}

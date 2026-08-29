import 'package:financeflow/core/database.dart';

import '../models/user.dart';

class UserDatasource {
  Future<int> insertUser(User user) async {
    final db = await DatabaseHelper.database;
    return await db.insert('user', user.toMap());
  }

  Future<User?> findByUsername(String username) async {
    final db = await DatabaseHelper.database;

    final result = await db.query(
      'user',
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return User.fromMap(result.first);
  }
}

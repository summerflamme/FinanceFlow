import 'package:financeflow/core/database.dart';
import 'package:financeflow/models/accounts.dart';
import 'package:sqflite/sqflite.dart';

class AccountsDatasource {
  Future<int> insertAccount(Account account) async {
    final db = await DatabaseHelper.database;

    return await db.insert(
      'accounts',
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

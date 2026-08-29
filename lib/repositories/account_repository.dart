import 'package:financeflow/datasource/accounts_datasource.dart';
import 'package:financeflow/models/accounts.dart';

class AccountRepository {
  final AccountsDatasource dataSource;
  AccountRepository(this.dataSource);

  Future<int> addAccount(Account account) async {
    return await dataSource.insertAccount(account);
  }
}

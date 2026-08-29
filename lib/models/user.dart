class User {
  int? id;
  String username;
  String password;
  int? account_id;

  User({
    this.id,
    required this.username,
    required this.password,
    this.account_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'account_id': account_id,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      account_id: map['account_id'],
    );
  }
}

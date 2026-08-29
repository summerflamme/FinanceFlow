class Account {
  int? id;
  String name;
  double balance;

  Account({this.id, required this.name, required this.balance});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'balance': balance};
  }
}

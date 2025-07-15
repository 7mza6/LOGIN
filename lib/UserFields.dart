class UserFields {
  static const String tableName = 'Users';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
  static const String id = '_id';
  static const String email = 'Email';
  static const String number = 'number';
  static const String password = 'Password';
  static const String username = 'Username';
  static const String phone = 'Phone';


  static const List<String> values = [
    id,
    email,
    password,
    username,
    phone,
  ];

}
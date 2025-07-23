import 'package:flutter/cupertino.dart';

import 'UserFields.dart';

class user {
final int? id;
final String? email;
final String? password;
final String? username;
final String? phone;

user({@required this.id, @required this.email, @required this.password,@required this.username,@required this.phone});

factory user.fromJson(Map<String, Object?> json) => user(
    id: json[UserFields.id] as int?,
    password: json[UserFields.password] as String?,
    username: json[UserFields.username] as String?,
    email: json[UserFields.email] as String?,
    phone : json[UserFields.phone] as String?);



Map<String,dynamic> toJson() => {
  UserFields.id : id,
  UserFields.email : email,
  UserFields.password : password,
  UserFields.username : username,
  UserFields.phone : phone,
};
user copy({
  int? id,
  String? password,
  String? username,
  String? email,
  String? phone,
}) =>
    user(
      id: id ?? this.id,
      password: password ?? this.password,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
}


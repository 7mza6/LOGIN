import 'package:flutter/cupertino.dart';

import 'UserFields.dart';

class user {
final int? id;
final String? email;
final String? password;
final String? username;
final String? phone;

user({@required this.id, @required this.email, @required this.password,@required this.username,@required this.phone});

 factory user.fromJson(Map<String, dynamic> json, String id) {
    return user(
      id: int.parse(id),
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  factory user.fromMap(Map<dynamic, dynamic> map) {
    return user(
      id: map['id'] as int,
      email: map['email'] as String,
      password: map['password'] as String,
      phone: map['phone'] as String,
      username: map['username'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
    };
  }
}


class CurrentUser {

  static user? currentUser;
  static user? getcurrentUser() => currentUser;
  static setcurrentUser(user? user) {
    currentUser = user;
    if (user != null) {
      currentUser = user;
      print('currentUser: ${currentUser?.email}');
    }
  }
  static void clearCurrentUser() {
    currentUser = null;
  }
}

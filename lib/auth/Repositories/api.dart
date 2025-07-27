import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';


class Api {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  Future<void> createUser(String uid, String name, String email, String password) async {
    await database.ref('users/$uid').set({
      'name': name,
      'email': email,
      'password': password,
    });
  }

}
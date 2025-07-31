import 'package:firebase_database/firebase_database.dart';
import 'package:users/auth/Repositories/userRepository.dart';

import '../models/userModel.dart';

class UserApi extends userRepository {
  static final FirebaseDatabase database = FirebaseDatabase.instance;  
  @override
  Future<user?> readUser(String username) async {
     final ref = FirebaseDatabase.instance.ref('users');
  DataSnapshot snapshot = await ref.get();

  if (snapshot.exists) {
    // The snapshot.value will be a Map<dynamic, dynamic> where keys are "13", "14", etc.
    Map<dynamic, dynamic>? usersData = snapshot.value as Map<dynamic, dynamic>?;

    if (usersData != null) {
      for (var entry in usersData.entries) {
        Map<dynamic, dynamic> userData = entry.value;
        if (userData['username'] == username) {
          return user.fromMap(userData);
        }
      }
    }
  }
  return null; // User not found
    
  }
  @override
  Future<int> update(user _user) {
    return database.ref('users/${_user.id.toString()}').update(_user.toJson()).then((value) {
      return 1;
    });
  }
  @override
  Future<user> create(user _user) {
    return database.ref('users/${_user.id.toString()}').set(_user.toJson()).then((value) {
      return _user;
    });
  }
  @override
  Future<int> delete(int id) {
    return database.ref('users/${id.toString()}').remove().then((value) {
      return 1;
    });
  }
  @override
  Future<List<user>> readAll() async {
     List<user> users = [];

  try {
    final snapshot = await database.ref('users').get();
    if (snapshot.exists && snapshot.value != null) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);

      data.forEach((key, value) {
        final userMap = Map<String, dynamic>.from(value);
        users.add(user.fromJson(userMap,key));
      });
    }
  } catch (e) {
    print('Error reading all users: $e');
  }

  return users;
  }

  @override
  Future<int> updatePassword(user _user, String newPassword) {
    return database.ref('users/${_user.username}').update({
      'password': newPassword,
    }).then((value) {
      return 1;
    });
  }
}
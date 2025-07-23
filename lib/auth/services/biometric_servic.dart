

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users/auth/Viewmodels/login_view_model.dart';
import 'package:users/auth/models/userModel.dart';

final storage = FlutterSecureStorage();

biometric_Enabled(bool val) async {
  await storage.write(key: 'biometric_Enabled', value:val == true?'true':'false');
}

Future<String?> getbiometric_Enabled() async {
  return await storage.read(key: 'biometric_Enabled');

}


storeUser(user _user) async {
  await storage.write(key: 'biometric_user', value: _user!.username);
  await storage.write(key: 'biometric_password', value: _user!.password);

  String? jsonData = await storage.read(key: 'userPasswords');
  Map<String, String> userPasswords;
  if (jsonData == null) {
    print("No credentials found.");
     userPasswords = {
    };
  }else
  userPasswords = Map<String, String>.from(jsonDecode(jsonData));



  jsonData = jsonEncode(userPasswords);
  await storage.write(key: 'userPasswords', value: jsonData);
}

biometricLogin(BuildContext context ) async {
  final isBiometricEnabled = await getbiometric_Enabled();
  String? username = await storage.read(key: 'biometric_user');
  String? password = await storage.read(key: 'biometric_password');

  if (username == null || isBiometricEnabled == 'false' || isBiometricEnabled == null) {
    Fluttertoast.showToast(msg: "No user linked to biometrics.");
    return;
  }


  final user? _user = await userDatabase.readUser(username);
  if (_user == null) {
    Fluttertoast.showToast(msg: "User not found in database.");
    return;
  }
  check(context, username!,password!);
}


void printAllCredentials() async {
  final secureStorage = FlutterSecureStorage();
  Map<String, String> allData = await secureStorage.readAll();

  allData.forEach((username, password) {
    print('User: $username, Password: $password');
  });
}
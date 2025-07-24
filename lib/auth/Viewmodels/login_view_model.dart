

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users/auth/Views/test.dart';
import '../Repositories/usersLocal.dart';
import '../reusable_widgets.dart';
import '../models/userModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/biometric_servic.dart';

UserDatabase userDatabase = UserDatabase.instance;

check(var context, String username,String password) async {
  user? _user = await userDatabase.readUser(username);
  if(_user == null){

    return ShowDialog(bodyText: AppLocalizations.of(context)!.loginfailed,
        context: context);

  }
  if (_user?.password == password) {
    storeUser(_user);
    final isBiometricEnabled = getbiometric_Enabled(_user);
    if(isBiometricEnabled == null) {
      biometric_Enabled(false,_user);

    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => (testPage(User: _user))),
    );

  } else {
    return ShowDialog(bodyText: AppLocalizations.of(context)!.loginfailed,
        context: context);
  }
}


LocalAuth(var context, var mounted) async {
  if (!await BiometricHelper.isBiometricSupported()) {
    Fluttertoast.showToast(msg: "Device does not support biometrics.");
    return;
  }

  final availableBiometrics = await BiometricHelper.getAvailableBiometrics();
  if (availableBiometrics.isEmpty) {
    Fluttertoast.showToast(msg: "No biometrics found. Please set it up.");
    return;
  }

  final bool didAuthenticate = await BiometricHelper.authenticate();
  if (didAuthenticate) {
    Map<String,String> userPasswords = await getAllUsers();

    String username = '7mza';
    //String username = selecteduser
    user? _user = await userDatabase.readUser(username);
    bool? switchVal1 = await getbiometric_Enabled(_user!);
    if (switchVal1!) {
      user? _user1 = await userDatabase.readUser(username);
      if (_user1 != null) {
      biometricLogin(context,_user1);
        
      }
    }

     
  }
}


Future<bool> auth() async {

  final LocalAuthentication auth = LocalAuthentication();

  try {
    bool authenticated = await auth. authenticate(
      localizedReason:
      'Subcribe or you will never find any stack overflow answer',
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: true,
      ),);
    print("Authenticated : $authenticated");

    return authenticated;

  } on PlatformException catch (e) {
    print(e);
    return false;
  }

}


class BiometricHelper {
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> isBiometricSupported() async {
    return await _auth.isDeviceSupported();
  }

  static Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _auth.getAvailableBiometrics();
  }

  static Future<bool> authenticate() async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Please authenticate to proceed',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      return didAuthenticate;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Biometric authentication failed. Try again!",
      );
      return false;
    }
  }



}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Repositories/user_api.dart';
import '../models/userModel.dart';
import '../Views/reusable_widgets.dart';


class RegisterViewModel {
  final UserApi _userDatabase = UserApi();

  Future<List<user>> getAllUsers() async {
    return await _userDatabase.readAll();
  }

  Future<void> printAllUsers() async {
    List<user> allUsers = await _userDatabase.readAll();
    for (var u in allUsers) {
      print(
          'ID: ${u.id}, Username: ${u.username}, Email: ${u.email}, Password: ${u.password} , phone: ${u.phone}');
    }
  }

  Future<user?> getUserByUsername(String username) async {
    return await _userDatabase.readUser(username);
  }

  Future<user?> registerUser({
    required String username,
    required String password,
    required String email,
    required String phone,
  }) async {
    List<user> users = await getAllUsers();
    int newId = users.isNotEmpty ? users.last.id! + 1 : 1;

    user newUser = user(
      id: newId,
      email: email,
      password: password,
      username: username,
      phone: phone,
    );

    return await _userDatabase.create(newUser);
  }


  Future<void> registerUserAndShowDialog({
    required BuildContext context,
    required String username,
    required String password,
    required String email,
    required String phone,
  }) async {
    List<user> useres = await _userDatabase.readAll();

    int newId = useres.isNotEmpty ? useres.last.id! + 1 : 1;

    user newUser = user(
      id: newId,
      username: username,
      password: password,
      email: email,
      phone: phone,
    );

    user? createdUser = await _userDatabase.create(newUser);  

    if (createdUser != null) {
      showCustomDialog(
        bodyText: AppLocalizations.of(context)!.regesteraitinDone,
        context: context,
      );
    } else {
      showCustomDialog(
        bodyText: AppLocalizations.of(context)!.regesteraitinfailed,
        context: context,
      );
    }
  }

}

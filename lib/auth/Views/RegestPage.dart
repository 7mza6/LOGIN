import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:users/auth/reusable_widgets.dart';
import '../Repositories/usersLocal.dart';
import '../Viewmodels/register_view_model.dart';
import '../models/userModel.dart';
import '../../main.dart';

String lang = 'en';
List<user> useres = [];

class RegestPage extends StatefulWidget {
  const RegestPage({super.key});

  @override
  State<RegestPage> createState() => _RegestPageState();
}

class _RegestPageState extends State<RegestPage> {
  UserDatabase userDatabase = UserDatabase.instance;
  final RegisterViewModel _viewModel = RegisterViewModel();

  TextEditingController usernaem = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(AppLocalizations.of(context)!.language);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.regesteraitin),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border:
                Border.all(width: 1, color: Colors.white.withOpacity(0.8)),
                color: Colors.white.withOpacity(0.1),
              ),
              width: 40,
              height: 40,
              child: TextButton(
                onPressed: () async {
                  String x = lang == 'ar' ? 'en' : 'ar';
                  lang = x;

                  MyApp.of(context)?.setLocale(Locale(x));
                  await Future.delayed(Duration(milliseconds: 20), () {
                    _formKey.currentState!.validate();
                  });
                },
                child: Text(
                  lang == 'ar' ? 'EN' : 'AR',
                  style: TextStyle(color: Colors.white),

                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.2),
              ),
              constraints: const BoxConstraints(
                minWidth: 250,
                maxWidth: 600,
                minHeight: 450,
                maxHeight: 600,
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              AppLocalizations.of(context)!.regesteraitin,
                              style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            flex: 11,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: usernaem,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .enterUsername;
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          labelText:
                                          AppLocalizations.of(context)!
                                              .username),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Expanded(
                                    child: TextFormField(
                                      controller: pass,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          labelText:
                                          AppLocalizations.of(context)!
                                              .password),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .enterPassword;
                                        } else if (value.length < 6) {
                                          return AppLocalizations.of(context)!
                                              .shortPassword;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Expanded(
                                    child: TextFormField(
                                      controller: email,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          labelText: AppLocalizations.of(
                                              context)!.email),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Expanded(
                                    child: TextFormField(
                                      controller: phone,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          labelText: AppLocalizations.of(
                                              context)!.phone),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    user? existingUser =
                                    await userDatabase.readUser(usernaem.text);
                                    if (existingUser != null) {
                                      _viewModel.printAllUsers();
                                      ShowDialog(
                                          bodyText:
                                          AppLocalizations.of(context)!
                                              .usernameTaken,
                                          context: context);
                                    } else {
                                      await _viewModel.registerUserAndShowDialog(
                                        context: context,
                                        username: usernaem.text,
                                        password: pass.text,
                                        email: email.text,
                                        phone: phone.text,
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  child: Text(
                                    AppLocalizations.of(context)!.regesteraitin,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
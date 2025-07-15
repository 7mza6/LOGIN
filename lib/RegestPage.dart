import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:users/Reusable.dart';
import 'package:users/user.dart';
import 'DataBase.dart';
import 'main.dart';

String lang = 'en';
List<user> useres = [];

class RegestPage extends StatefulWidget {
  const RegestPage({super.key});

  @override
  State<RegestPage> createState() => _RegestPageState();
}

class _RegestPageState extends State<RegestPage> {
  UserDatabase userDatabase = UserDatabase.instance;
  getAll() async {
    userDatabase.readAll().then((value) {
      setState(() {
        useres = value;
      });
    });
  }

  void printAllUsers() async {
    List<user> allUsers = await userDatabase.readAll();

    for (var u in allUsers) {
      print(
          'ID: ${u.id}, Username: ${u.username}, Email: ${u.email}, Password: ${u.password} , phone: ${u.phone} ');
    }
  }

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
                                          return AppLocalizations.of(context)!.enterUsername;
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          labelText:
                                              AppLocalizations.of(context)!.username),
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
                                              AppLocalizations.of(context)!.password),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppLocalizations.of(context)!.enterPassword;
                                        } else if (value.length < 6) {
                                          return AppLocalizations.of(context)!.shortPassword;
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
                                          labelText: AppLocalizations.of(context)!.email),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Expanded(
                                    child: TextFormField(
                                      controller: phone,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          labelText: AppLocalizations.of(context)!.phone),
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
                                      printAllUsers();
                                      ShowDialog(
                                          bodyText:
                                              AppLocalizations.of(context)!.usernameTaken,
                                          context: context);
                                    } else {
                                      add();
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

  add() async {
    // Fetch all users first
    await getAll();

    int newId = 1;
    if (useres.isNotEmpty) {
      newId = useres.last.id! + 1;
    }

    user newUser = user(
      id: newId,
      email: email.text,
      password: pass.text,
      username: usernaem.text,
      phone: phone.text,
    );

    user? createdUser = await userDatabase.create(newUser);

    if (createdUser != null) {
      return ShowDialog(
        bodyText: AppLocalizations.of(context)!.regesteraitinDone,
        context: context,
      );
    } else {
      return ShowDialog(
        bodyText: AppLocalizations.of(context)!.regesteraitinfailed,
        context: context,
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:users/user.dart';
import 'DataBase.dart';
import 'RegestPage.dart';
import 'Reusable.dart';
import 'main.dart';

String lang = 'en';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserDatabase userDatabase = UserDatabase.instance;

  List<user> useres = [];

  TextEditingController usernaem = TextEditingController();
  TextEditingController pass = TextEditingController();
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
            Text(AppLocalizations.of(context)!.login),
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
                onPressed: () {
                  String x = lang == 'ar' ? 'en' : 'ar';
                  lang = x;
                  MyApp.of(context)?.setLocale(Locale(x));
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
                constraints: const BoxConstraints(
                  minWidth: 250,
                  maxWidth: 600,
                  minHeight: 370,
                  maxHeight: 500,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.2),
                ),

                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(

                    children: [
                      Expanded(
                        child: Column(

                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                AppLocalizations.of(context)!.login,
                                style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Form(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: usernaem,
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(),
                                            labelText: AppLocalizations.of(context)!.username),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a username';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Expanded(
                                      child: TextFormField(
                                        controller: pass,
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(),
                                            labelText: AppLocalizations.of(context)!.password),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a password';
                                          } else if (value.length < 6) {
                                            return 'Password must be at least 6 characters long';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextButton(
                                  onPressed:() => check(),
                                  child: Container(
                                    child: Text(
                                      AppLocalizations.of(context)!.login,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextButton(
                                  onPressed:() {
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => RegestPage()),
                                  );
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

  check() async {
    user? _user = await userDatabase.readUser(usernaem.text);
    if(_user == null){

      return ShowDialog(bodyText: AppLocalizations.of(context)!.loginfailed,
          context: context);

    }
    if (_user?.password == pass.text) {
        return ShowDialog(bodyText: AppLocalizations.of(context)!.loginMassage,
            context: context);
      } else {
        return ShowDialog(bodyText: AppLocalizations.of(context)!.loginfailed,
            context: context);
      }
  }
}






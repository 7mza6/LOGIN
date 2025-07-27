import 'package:flutter/material.dart';
import 'auth/Repositories/usersLocal.dart';
import 'auth/Views/LoginPage.dart';
import 'l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'auth/models/userModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}




class MyApp extends StatefulWidget {

  const MyApp({super.key});

  // A static method to easily access the state from anywhere in the widget tree
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); // Initial locale

  // Method to update the locale
   setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }


  List<user> useres = [];

  UserDatabase noteDatabase = UserDatabase.instance;


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: L10n.all,
      locale: _locale, // Use the state variable here
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
      ),
      home: LoginPage(),

    );
  }
}
//MyApp.of(context)?.setLocale(const Locale('ar'))
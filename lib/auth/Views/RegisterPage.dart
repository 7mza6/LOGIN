// lib/auth/Views/RegisterPage.dart

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:users/auth/Views/reusable_widgets.dart';
import '../Repositories/user_api.dart';
import '../Viewmodels/register_view_model.dart';
import '../models/userModel.dart';
import '../../main.dart';
import '../../Views/constants.dart';

String lang = kDefaultLanguage;

class RegestPage extends StatefulWidget {
  const RegestPage({super.key});
  @override
  State<RegestPage> createState() => _RegestPageState();
}

class _RegestPageState extends State<RegestPage> {
  final UserApi userDatabase = UserApi();
  final RegisterViewModel _viewModel = RegisterViewModel();
  final TextEditingController usernaem = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.regesteraitin),
            _buildLanguageButton(context),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kBackgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: kPagePadding,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: kBorderRadius10,
                color: kFormBackgroundColor,
              ),
              constraints: const BoxConstraints(
                minWidth: kFormMinWidth,
                maxWidth: kFormMaxWidth,
                minHeight: kRegisterFormMinHeight,
                maxHeight: kRegisterFormMaxHeight,
              ),
              child: Padding(
                padding: kSheetPadding,
                child: _buildRegisterForm(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(width: kLanguageButtonBorderWidth, color: kLanguageButtonBorderColor),
        color: kLanguageButtonBackgroundColor,
      ),
      width: kLanguageButtonSize,
      height: kLanguageButtonSize,
      child: TextButton(
        onPressed: () async {
          String newLang = lang == kArabicLanguage ? kEnglishLanguage : kArabicLanguage;
          setState(() {
            lang = newLang;
          });
          MyApp.of(context)?.setLocale(Locale(newLang));
          await Future.delayed(const Duration(milliseconds: 20), () {
            _formKey.currentState!.validate();
          });
        },
        child: Text(
          lang == kArabicLanguage ? 'EN' : 'AR',
          style: kLanguageButtonTextStyle,
        ),
      ),
    );
  }

  Widget _buildRegisterForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          Text(
            AppLocalizations.of(context)!.regesteraitin,
            style: kAuthTitleStyle,
          ),
          const Spacer(flex: 1),
          TextFormField(
            controller: usernaem,
            validator: (value) => (value == null || value.isEmpty) ? AppLocalizations.of(context)!.enterUsername : null,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: const OutlineInputBorder(),
              labelText: AppLocalizations.of(context)!.username,
            ),
          ),
          kHeightSpacer20,
          TextFormField(
            controller: pass,
            obscureText: true,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: const OutlineInputBorder(),
              labelText: AppLocalizations.of(context)!.password,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return AppLocalizations.of(context)!.enterPassword;
              if (value.length < 6) return AppLocalizations.of(context)!.shortPassword;
              return null;
            },
          ),
          kHeightSpacer20,
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: const OutlineInputBorder(),
              labelText: AppLocalizations.of(context)!.email,
            ),
          ),
          kHeightSpacer20,
          TextFormField(
            controller: phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: const OutlineInputBorder(),
              labelText: AppLocalizations.of(context)!.phone,
            ),
          ),
          const Spacer(flex: 1),
          TextButton(
            onPressed: _handleRegistration,
            child: Text(
              AppLocalizations.of(context)!.regesteraitin,
              style: kAuthButtonTextStyle,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  void _handleRegistration() async {
    if (_formKey.currentState!.validate()) {
      user? existingUser = await userDatabase.readUser(usernaem.text);
      if (existingUser != null) {
        showCustomDialog(
          context: context,
          bodyText: AppLocalizations.of(context)!.usernameTaken,
        );
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
  }
}
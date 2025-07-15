import 'package:flutter/material.dart';
import 'package:users/user.dart';
import 'DataBase.dart';
import 'l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'LoginPage.dart';

ShowDialog({var context, bodyText}){

  showDialog<String>(
    context: context,
    builder:
        (BuildContext context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(bodyText),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:  Text(AppLocalizations.of(context)!.close),
            ),
          ],
        ),
      ),
    ),
  );
}


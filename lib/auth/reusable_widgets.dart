import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

ShowDialog({var context, bodyText,bool? swich}){

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
            Visibility(visible: swich ?? false ,
                child: Switch(
              value: true,
              onChanged: (value) {

              },
            ) ),
          ],
        ),
      ),
    ),
  );
}


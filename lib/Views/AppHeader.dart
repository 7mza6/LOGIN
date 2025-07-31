

import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


PreferredSizeWidget AppHeader(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title:  Text(AppLocalizations.of(context)!.kAppHeaderTitle),
    actions: [
      IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () {
          // Do something when the notifications icon is pressed
        },
      ),
    ],
  );
}
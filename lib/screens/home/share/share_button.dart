import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:soccer/logic/i18n/i18n.dart';
import 'package:soccer/values/values.dart';

class ShareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: DecoratedBox(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            I18N.home('invite friends').split(' ').join('\n'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      onTap: () => Share.share(
        'Check out this app! ' +
            (io.Platform.isAndroid
                ? StoreURL.android.label
                : StoreURL.ios.label),
      ),
    );
  }
}

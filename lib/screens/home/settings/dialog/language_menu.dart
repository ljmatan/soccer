import 'package:flutter/material.dart';
import 'package:soccer/logic/i18n/locale_controller.dart';

class LanguageMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlatButton(
          child: Text('English'),
          onPressed: () {
            AppLocale.change('en');
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('Hrvatski'),
          onPressed: () {
            AppLocale.change('hr');
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

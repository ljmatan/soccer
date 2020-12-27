import 'package:flutter/material.dart';
import 'package:soccer/logic/i18n/i18n.dart';
import 'package:soccer/screens/home/settings/settings_button.dart';
import 'package:soccer/screens/home/share/share_button.dart';
import 'package:soccer/screens/penalty_match/penalty_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: SettingsButton(),
            ),
            FlatButton(
              child: Text(I18N.home('tap me')),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => PenaltyScreen(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                children: [
                  ShareButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:soccer/global/values.dart';
import 'package:soccer/logic/audio/music.dart';
import 'package:soccer/logic/i18n/i18n.dart';
import 'package:soccer/screens/home/settings/dialog/language_button.dart';
import 'package:soccer/screens/home/settings/dialog/language_menu.dart';
import 'package:soccer/screens/home/settings/dialog/toggle_button.dart';
import 'package:soccer/screens/home/settings/dialog/url_button.dart';

class SettingsDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsDialogState();
  }
}

class _SettingsDialogState extends State<SettingsDialog> {
  bool _languageSelection = false;

  void _enterLanguageMenu() => setState(() => _languageSelection = true);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: _languageSelection
                  ? LanguageMenu()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              I18N.settings('settings'),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              child: Icon(Icons.close),
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ToggleButton(
                                label: 'MUSIC',
                                onTap: (value) => value
                                    ? MusicPlayer.stop()
                                    : MusicPlayer.play(),
                                value: Cached.music.label,
                              ),
                              ToggleButton(
                                label: 'EFFECTS',
                                onTap: (value) => null,
                                value: null,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ToggleButton(
                              label: 'NOTIFICATIONS',
                              onTap: (value) => null,
                              value: null,
                            ),
                            LanguageButton(onTap: () => _enterLanguageMenu()),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              URLButton(
                                label: 'GET IN\nTOUCH',
                                url: 'mailto:coorangar.sup@gmail.com'
                                    '?subject=Request Idle Goals',
                              ),
                              URLButton(
                                label: 'TERMS OF\nSERVICE',
                                url: 'https://google.com/',
                              ),
                              URLButton(
                                label: 'PRIVACY\nPOLICY',
                                url: 'https://google.de/',
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
    );
  }
}

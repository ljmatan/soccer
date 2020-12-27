import 'dart:async';

import 'package:soccer/logic/cache/prefs.dart';

abstract class AppLocale {
  static String _languageCode;
  static String get languageCode => _languageCode;

  static StreamController _streamController;

  static void init() {
    _streamController = StreamController.broadcast();
    _languageCode = Prefs.instance.getString('locale') ?? 'en';
  }

  static Stream get stream => _streamController.stream;

  static void change(String newLanguageCode) {
    if (_languageCode != newLanguageCode) {
      _languageCode = newLanguageCode;
      _streamController.add(newLanguageCode);
      Prefs.instance.setString('locale', newLanguageCode);
    }
  }
}

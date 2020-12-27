import 'package:soccer/logic/i18n/locale_controller.dart';

import 'string_values.dart';

abstract class I18N {
  static String home(String value) =>
      StringValues.values[AppLocale.languageCode]['home'][value];

  static String settings(String value) =>
      StringValues.values[AppLocale.languageCode]['settings'][value];
}

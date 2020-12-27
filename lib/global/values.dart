enum Cached { music, locale }

extension CachedExtension on Cached {
  String get label {
    switch (this) {
      case Cached.locale:
        return 'locale';
      case Cached.music:
        return 'music';
      default:
        return null;
    }
  }
}

enum StoreURL { android, ios }

extension StoreURLExtension on StoreURL {
  String get label {
    switch (this) {
      case StoreURL.android:
        return 'https://play.google.com/store/apps/details?id=';
      case StoreURL.ios:
        return 'https://apps.apple.com/us/app/appname/id';
      default:
        return null;
    }
  }
}

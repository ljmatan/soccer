import 'dart:io' as io;

import 'package:package_info/package_info.dart';
import 'package:soccer/logic/http/http_helper.dart';

abstract class AppVersion {
  static Future<String> _getLatestVersion() async => await HTTPHelper.get(
        'app/versions/' + (io.Platform.isAndroid ? 'android' : 'ios') + '.json',
      );

  static Future<bool> checkLatest() async {
    PackageInfo appInfo = await PackageInfo.fromPlatform();

    final String installedVersion = appInfo.version;

    final String latestVersion = await _getLatestVersion();

    return installedVersion == latestVersion;
  }
}

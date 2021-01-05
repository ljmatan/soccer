import 'dart:io' as io;

import 'package:soccer/logic/auth/firebase_auth.dart';
import 'package:soccer/logic/http/http_helper.dart';
import 'package:device_info/device_info.dart';

abstract class LastLogin {
  static Future<void> update() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo;
    IosDeviceInfo iosInfo;
    io.Platform.isAndroid
        ? androidInfo = await deviceInfo.androidInfo
        : iosInfo = await deviceInfo.iosInfo;

    await HTTPHelper.patch('users/${Auth.user.uid}.json', {
      'lastLogin': DateTime.now().toIso8601String(),
      'device': io.Platform.isAndroid
          ? androidInfo.androidId
          : iosInfo.identifierForVendor,
    });
  }
}

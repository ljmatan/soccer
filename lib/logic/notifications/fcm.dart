import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:soccer/logic/http/http_helper.dart';

abstract class Notifications {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static Future<void> notificationsEnabled(bool enabled) async {
    final response = await HTTPHelper.patch('');
  }
}

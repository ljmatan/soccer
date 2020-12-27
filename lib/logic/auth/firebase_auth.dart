import 'package:firebase_auth/firebase_auth.dart';

abstract class Auth {
  static FirebaseAuth get instance => FirebaseAuth.instance;

  static Future<UserCredential> anonSignIn() async =>
      await FirebaseAuth.instance.signInAnonymously();

  static User user;

  static Future<void> init() async {
    user = instance.currentUser;
    if (user == null) user = (await anonSignIn()).user;
  }
}

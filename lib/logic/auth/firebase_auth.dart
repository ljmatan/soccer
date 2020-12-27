import 'package:firebase_auth/firebase_auth.dart';

abstract class Auth {
  static FirebaseAuth get instance => FirebaseAuth.instance;

  static UserCredential userCredential;

  static Future<void> anonSignIn() async =>
      userCredential = await FirebaseAuth.instance.signInAnonymously();
}

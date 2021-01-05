import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:soccer/global/values.dart';
import 'package:soccer/logic/admob/admob.dart';
import 'package:soccer/logic/audio/music.dart';
import 'package:soccer/logic/auth/firebase_auth.dart';
import 'package:soccer/logic/cache/prefs.dart';
import 'package:soccer/logic/i18n/locale_controller.dart';
import 'package:soccer/logic/app_version/app_version.dart';
import 'package:soccer/logic/last_login/last_login.dart';
import 'package:soccer/screens/home/home_screen.dart';
import 'package:soccer/screens/init_error/init_error.dart';
import 'package:soccer/screens/update_app/update_app.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

void main() async {
  String _errorMessage;

  bool _upToDate;

  // Required by the framework
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialise Firebase services
    await Firebase.initializeApp();

    // Initialise authentication services and login as anonymous if the user is currently not logged in
    await Auth.init();

    // Initialise cache storage
    await Prefs.init();

    // Set app language
    AppLocale.init();

    // Initialise ad network
    await AdMob.init();

    // Initialise app store purchases
    InAppPurchaseConnection.enablePendingPurchases();

    _upToDate =
        // Check whether user has the latest app version installed
        await AppVersion.checkLatest();

    // Initialise music player and start the track if music option is enabled
    if (_upToDate) {
      MusicPlayer.init();
      await LastLogin.update();
    }
  } catch (e) {
    _errorMessage = e.toString();
  }

  runApp(SoccerApp(error: _errorMessage, upToDate: _upToDate));
}

class SoccerApp extends StatefulWidget {
  final String error;
  final bool upToDate;

  SoccerApp({@required this.error, @required this.upToDate});

  @override
  State<StatefulWidget> createState() {
    return _SoccerAppState();
  }
}

class _SoccerAppState extends State<SoccerApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (Prefs.instance.getBool(Cached.music.label)) {
      if (state == AppLifecycleState.paused)
        MusicPlayer.stop();
      else
        MusicPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      home: widget.error != null
          ? InitErrorScreen(errorMessage: widget.error)
          : StreamBuilder(
              stream: AppLocale.stream,
              builder: (context, locale) =>
                  widget.upToDate ? HomeScreen() : UpdateAppScreen(),
            ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

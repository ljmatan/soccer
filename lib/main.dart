import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:soccer/logic/admob/admob.dart';
import 'package:soccer/logic/audio/music.dart';
import 'package:soccer/logic/cache/prefs.dart';
import 'package:soccer/logic/i18n/locale_controller.dart';
import 'package:soccer/logic/init/app_version.dart';
import 'package:soccer/screens/home/home_screen.dart';
import 'package:soccer/screens/update_app/update_app.dart';

void main() async {
  // Required by the framework
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise Firebase services
  await Firebase.initializeApp();

  // Initialise cache storage
  await Prefs.init();

  // Set app language
  AppLocale.init();

  // Initialise ad network - https://github.com/FirebaseExtended/flutterfire/issues/4505
  // await AdMob.init();

  // Initialise music player and start the track if music option is enabled
  MusicPlayer.init();

  bool _appUpToDate =
      // Check whether user has the latest version installed
      await AppVersion.checkLatest();

  runApp(SoccerApp(upToDate: _appUpToDate));
}

class SoccerApp extends StatefulWidget {
  final bool upToDate;

  SoccerApp({@required this.upToDate});

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
    if (Prefs.instance.getBool('MUSIC')) {
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
      home: StreamBuilder(
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

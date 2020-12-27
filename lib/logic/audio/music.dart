import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:soccer/logic/cache/prefs.dart';

abstract class MusicPlayer {
  static AudioCache _audioCache;

  static AudioPlayer _player;

  static Future<AudioPlayer> getAudioPlayer(String filename) =>
      _audioCache.loop(filename, volume: 0);

  static void play() => _player.resume();

  static void stop() => _player.pause();

  static void init() async {
    _audioCache = AudioCache();
    final bool _active = Prefs.instance.getBool('MUSIC') ?? true;
    _player = await getAudioPlayer('music.mp3');
    if (!_active) await _player.pause();
    _player.setVolume(1);
  }

  static void dispose() {
    _audioCache.clearCache();
    _player.dispose();
  }
}

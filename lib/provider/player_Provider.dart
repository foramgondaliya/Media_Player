import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class PlayerProvider with ChangeNotifier {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  bool isPlaying = false;
  String currentAudioPath = '';
  Stream<Duration> get currentPosition => _assetsAudioPlayer.currentPosition;
  Stream<Playing?> get current => _assetsAudioPlayer.current;

  void togglePlayPause(String audioPath) {
    if (isPlaying && currentAudioPath == audioPath) {
      _assetsAudioPlayer.pause();
      isPlaying = false;
    } else {
      _assetsAudioPlayer.open(
        Audio(audioPath),
        autoStart: true,
      );
      currentAudioPath = audioPath;
      isPlaying = true;
    }
    notifyListeners();
  }

  void seek(Duration position) {
    _assetsAudioPlayer.seek(position);
  }
}

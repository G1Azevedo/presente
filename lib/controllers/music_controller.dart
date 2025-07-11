import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class MusicController {
  static final MusicController _instance = MusicController._internal();
  factory MusicController() => _instance;

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isInitialized = false;
  ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> isMutedNotifier = ValueNotifier<bool>(false);

  MusicController._internal() {
    _audioPlayer.playingStream.listen((playing) {
      isPlayingNotifier.value = playing;
    });
    _audioPlayer.volumeStream.listen((volume) {
      isMutedNotifier.value = volume == 0.0;
    });
  }

  Future<void> initializePlayer({required String assetPath}) async {
    if (_isInitialized) return;

    try {
      await _audioPlayer.setAsset(assetPath);
      await _audioPlayer.setLoopMode(LoopMode.one);
      _isInitialized = true;
    } catch (e) {
      debugPrint("Erro ao inicializar o áudio: $e");
    }
  }

  Future<void> play() async {
    if (!_isInitialized || _audioPlayer.playing) return;
    try {
      await _audioPlayer.play();
      isPlayingNotifier.value = true;
    } catch (e) {
      debugPrint("Erro ao tocar áudio: $e");
    }
  }

  Future<void> pause() async {
    if (!_isInitialized || !_audioPlayer.playing) return;
    try {
      await _audioPlayer.pause();
      isPlayingNotifier.value = false;
    } catch (e) {
      debugPrint("Erro ao pausar áudio: $e");
    }
  }

  Future<void> toggleMute() async {
    if (!_isInitialized) return;
    final currentVolume = _audioPlayer.volume;
    if (currentVolume > 0) {
      await _audioPlayer.setVolume(0.0);
      isMutedNotifier.value = true;
    } else {
      await _audioPlayer.setVolume(1.0);
      isMutedNotifier.value = false;
    }
  }

  Future<void> ensurePlaying() async {
    if (_isInitialized && !_audioPlayer.playing && !isMutedNotifier.value) {
      await play();
    }
  }


  void dispose() {
    _audioPlayer.dispose();
    isPlayingNotifier.dispose();
    isMutedNotifier.dispose();
  }
}
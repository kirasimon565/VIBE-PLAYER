import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';
import '../models/media_item.dart';
import 'dart:io';

class PlaybackService extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  VideoPlayerController? _videoController;

  MediaItem? _currentItem;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  double _volume = 1.0;

  MediaItem? get currentItem => _currentItem;
  bool get isPlaying => _isPlaying;
  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;
  VideoPlayerController? get videoController => _videoController;

  PlaybackService() {
    _initAudioListeners();
  }

  void _initAudioListeners() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      _totalDuration = duration;
      notifyListeners();
    });
  }

  Future<void> play(MediaItem item) async {
    _currentItem = item;

    if (item.isVideo) {
      await _audioPlayer.stop();
      _videoController?.dispose();

      if (item.path.startsWith('http')) {
        _videoController = VideoPlayerController.networkUrl(Uri.parse(item.path));
      } else {
        _videoController = VideoPlayerController.file(File(item.path));
      }

      await _videoController!.initialize();
      _videoController!.play();
      _isPlaying = true;
      _totalDuration = _videoController!.value.duration;

      _videoController!.addListener(() {
        if (_videoController!.value.isPlaying != _isPlaying) {
          _isPlaying = _videoController!.value.isPlaying;
        }
        _currentPosition = _videoController!.value.position;
        notifyListeners();
      });
    } else {
      _videoController?.pause();
      if (item.path.isNotEmpty) {
        if (item.path.startsWith('http')) {
          await _audioPlayer.play(UrlSource(item.path));
        } else {
          await _audioPlayer.play(DeviceFileSource(item.path));
        }
      }
    }
    notifyListeners();
  }

  Future<void> pause() async {
    if (_currentItem?.isVideo == true) {
      _videoController?.pause();
    } else {
      await _audioPlayer.pause();
    }
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> resume() async {
    if (_currentItem?.isVideo == true) {
      _videoController?.play();
    } else {
      await _audioPlayer.resume();
    }
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> seek(Duration position) async {
    if (_currentItem?.isVideo == true) {
      await _videoController?.seekTo(position);
    } else {
      await _audioPlayer.seek(position);
    }
    _currentPosition = position;
    notifyListeners();
  }

  Future<void> setVolume(double volume) async {
    _volume = volume;
    if (_currentItem?.isVideo == true) {
      await _videoController?.setVolume(volume);
    } else {
      await _audioPlayer.setVolume(volume);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _videoController?.dispose();
    super.dispose();
  }
}

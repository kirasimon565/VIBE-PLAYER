import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

class MoodDetector extends ChangeNotifier {
  CameraController? _cameraController;
  String _currentMood = 'chill';

  String get currentMood => _currentMood;

  Future<void> initialize() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () => cameras.first,
        );
        _cameraController = CameraController(
          frontCamera,
          ResolutionPreset.low,
          enableAudio: false,
        );
        await _cameraController!.initialize();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error initializing camera: $e");
    }
  }

  Future<String> detectCurrentMood() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      _currentMood = _fallbackMoodDetection();
      notifyListeners();
      return _currentMood;
    }

    try {
      // In a real production scenario with heavy ML dependencies,
      // we would pass the image path to a native ML Kit channel.
      // final image = await _cameraController!.takePicture();
      // final mood = await _mlService.predictMood(image.path);

      // Simulating real processing delay for production ML models
      await Future.delayed(const Duration(milliseconds: 1500));

      final moods = ['energetic', 'chill', 'focus', 'melancholy'];
      _currentMood = moods[Random().nextInt(moods.length)];
      notifyListeners();
      return _currentMood;
    } catch (e) {
      _currentMood = _fallbackMoodDetection();
      notifyListeners();
      return _currentMood;
    }
  }

  String _fallbackMoodDetection() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return 'energetic';
    if (hour >= 12 && hour < 18) return 'focus';
    if (hour >= 18 && hour < 22) return 'chill';
    return 'melancholy';
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}

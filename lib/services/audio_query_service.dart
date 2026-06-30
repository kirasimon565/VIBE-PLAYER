import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AudioQueryService {
  static const MethodChannel _channel = MethodChannel('com.example.vibe_player/audio_query');

  /// Fetch all local audio files from device
  static Future<List<Map<String, dynamic>>> getLocalSongs() async {
    try {
      final List<dynamic> result = await _channel.invokeMethod('getAudioFiles');
      return result.map((item) => Map<String, dynamic>.from(item)).toList();
    } on PlatformException catch (e) {
      debugPrint('Failed to get audio files: ${e.message}');
      return [];
    } catch (e) {
      debugPrint('Unexpected error getting audio files: $e');
      return [];
    }
  }

  /// Check if storage permission is granted
  static Future<bool> checkPermissions() async {
    try {
      final bool? result = await _channel.invokeMethod('checkPermissions');
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('Failed to check permissions: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Unexpected permission check error: $e');
      return false;
    }
  }

  /// Request storage permission
  static Future<void> requestPermissions() async {
    try {
      await _channel.invokeMethod('requestPermissions');
    } on PlatformException catch (e) {
      debugPrint('Failed to request permissions: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected permission request error: $e');
    }
  }
}

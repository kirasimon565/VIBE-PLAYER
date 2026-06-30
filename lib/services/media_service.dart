import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/media_item.dart';

class MediaService {
  static const MethodChannel _channel = MethodChannel('com.example.vibe_player/audio_query');

  /// Fetch all local audio files from device
  static Future<List<MediaItem>> getAllMedia() async {
    try {
      // Check permissions
      final bool hasPermission = await checkPermissions();
      if (!hasPermission) {
        await requestPermissions();
        // Wait a moment for permission dialog
        await Future.delayed(const Duration(milliseconds: 500));
        final bool granted = await checkPermissions();
        if (!granted) return [];
      }

      // Fetch songs from native code
      final List<dynamic> result = await _channel.invokeMethod('getAudioFiles');
      final List<Map<String, dynamic>> songs = result.map((item) => Map<String, dynamic>.from(item)).toList();

      return songs.map((song) => MediaItem(
        id: song['id']?.toString() ?? '',
        title: song['title'] ?? 'Unknown Title',
        artist: song['artist'] ?? 'Unknown Artist',
        album: song['album'] ?? 'Unknown Album',
        path: song['path'] ?? '',
        duration: Duration(milliseconds: song['duration'] ?? 0),
        isVideo: false,
      )).toList();
    } on PlatformException catch (e) {
      debugPrint('Failed to get audio files: ${e.message}');
      return [];
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return [];
    }
  }

  /// Get random recent media (shuffled from all songs)
  static Future<List<MediaItem>> getRecentMedia() async {
    final all = await getAllMedia();
    if (all.isEmpty) return [];
    final list = List<MediaItem>.from(all)..shuffle();
    return list.take(5).toList();
  }

  /// Get random trending media (shuffled from all songs)
  static Future<List<MediaItem>> getTrendingMedia() async {
    final all = await getAllMedia();
    if (all.isEmpty) return [];
    final list = List<MediaItem>.from(all)..shuffle();
    return list.take(10).toList();
  }

  /// Check if storage permission is granted
  static Future<bool> checkPermissions() async {
    try {
      final bool? result = await _channel.invokeMethod('checkPermissions');
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('Failed to check permissions: ${e.message}');
      return false;
    }
  }

  /// Request storage permission
  static Future<void> requestPermissions() async {
    try {
      await _channel.invokeMethod('requestPermissions');
    } on PlatformException catch (e) {
      debugPrint('Failed to request permissions: ${e.message}');
    }
  }
}

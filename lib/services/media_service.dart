import 'package:on_audio_query/on_audio_query.dart';
import '../models/media_item.dart';

class MediaService {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<MediaItem>> getAllMedia() async {
    try {
      bool hasPermission = await _audioQuery.permissionsStatus();
      if (!hasPermission) {
        hasPermission = await _audioQuery.permissionsRequest();
      }

      if (!hasPermission) return [];

      List<SongModel> songs = await _audioQuery.querySongs();
      return songs.map((song) => MediaItem(
        id: song.id.toString(),
        title: song.title,
        artist: song.artist ?? 'Unknown Artist',
        album: song.album ?? 'Unknown Album',
        path: song.data,
        duration: Duration(milliseconds: song.duration ?? 0),
        isVideo: false,
      )).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<MediaItem>> getRecentMedia() async {
    final all = await getAllMedia();
    if (all.isEmpty) return [];
    final list = List<MediaItem>.from(all)..shuffle();
    return list.take(5).toList();
  }

  Future<List<MediaItem>> getTrendingMedia() async {
    final all = await getAllMedia();
    if (all.isEmpty) return [];
    final list = List<MediaItem>.from(all)..shuffle();
    return list.take(10).toList();
  }
}

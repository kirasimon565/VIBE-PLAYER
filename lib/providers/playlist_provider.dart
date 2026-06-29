import 'package:flutter/foundation.dart';
import '../models/playlist.dart';
import '../models/media_item.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Playlist> _playlists = [];

  List<Playlist> get playlists => _playlists;

  void addPlaylist(Playlist playlist) {
    _playlists.add(playlist);
    notifyListeners();
  }

  void addToPlaylist(String playlistId, MediaItem item) {
    final playlist = _playlists.firstWhere((p) => p.id == playlistId);
    playlist.items.add(item);
    notifyListeners();
  }
}

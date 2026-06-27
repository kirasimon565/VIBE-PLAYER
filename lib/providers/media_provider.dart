import 'package:flutter/foundation.dart';
import '../models/media_item.dart';
import '../services/media_service.dart';

class MediaProvider extends ChangeNotifier {
  final MediaService _mediaService = MediaService();
  List<MediaItem> _allMedia = [];
  List<MediaItem> _recentMedia = [];
  List<MediaItem> _trendingMedia = [];
  bool _isLoading = false;

  List<MediaItem> get allMedia => _allMedia;
  List<MediaItem> get recentMedia => _recentMedia;
  List<MediaItem> get trendingMedia => _trendingMedia;
  bool get isLoading => _isLoading;

  Future<void> loadMedia() async {
    _isLoading = true;
    notifyListeners();

    _allMedia = await _mediaService.getAllMedia();
    _recentMedia = await _mediaService.getRecentMedia();
    _trendingMedia = await _mediaService.getTrendingMedia();

    _isLoading = false;
    notifyListeners();
  }
}

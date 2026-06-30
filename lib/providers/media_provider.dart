import 'package:flutter/foundation.dart';
import '../models/media_item.dart';
import '../services/media_service.dart';

class MediaProvider extends ChangeNotifier {
  // ✅ Remove the instance - use static methods directly
  List<MediaItem> _allMedia = [];
  List<MediaItem> _recentMedia = [];
  List<MediaItem> _trendingMedia = [];
  bool _isLoading = false;
  String? _error;

  List<MediaItem> get allMedia => _allMedia;
  List<MediaItem> get recentMedia => _recentMedia;
  List<MediaItem> get trendingMedia => _trendingMedia;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadMedia() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // ✅ Call static methods directly on the class
      _allMedia = await MediaService.getAllMedia();
      _recentMedia = await MediaService.getRecentMedia();
      _trendingMedia = await MediaService.getTrendingMedia();
    } catch (e) {
      _error = e.toString();
      debugPrint('Error loading media: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearMedia() {
    _allMedia = [];
    _recentMedia = [];
    _trendingMedia = [];
    _error = null;
    notifyListeners();
  }
}

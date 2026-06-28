import '../models/media_item.dart';
import '../models/playback_history.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AIRecommendationService {
  final String baseUrl = 'https://api.vibeplayer.com/v1';

  Future<List<MediaItem>> getRecommendations(List<MediaItem> allMedia, List<PlaybackHistoryItem> history) async {
    if (history.isEmpty || allMedia.isEmpty) {
      final shuffled = List<MediaItem>.from(allMedia)..shuffle();
      return shuffled.take(10).toList();
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/ai/recommend'),
        body: json.encode({
          'history': history.map((e) => e.toJson()).toList(),
          'availableIds': allMedia.map((e) => e.id).toList(),
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> recommendedIds = json.decode(response.body)['recommendations'];
        return allMedia.where((item) => recommendedIds.contains(item.id)).toList();
      }
    } catch (e) {
      // Fallback to local heuristic if offline
    }

    // Heuristic Fallback
    Map<String, int> tagFrequency = {};
    for (var hItem in history.take(20)) {
      final media = allMedia.firstWhere(
        (m) => m.id == hItem.mediaId,
        orElse: () => allMedia.first
      );
      for (var tag in media.tags) {
        tagFrequency[tag] = (tagFrequency[tag] ?? 0) + 1;
      }
    }

    final sortedTags = tagFrequency.keys.toList()
      ..sort((a, b) => tagFrequency[b]!.compareTo(tagFrequency[a]!));

    final topTags = sortedTags.take(3).toList();

    List<MediaItem> recommendations = allMedia.where((item) {
      return item.tags.any((tag) => topTags.contains(tag));
    }).toList();

    recommendations.shuffle();

    if (recommendations.length < 10) {
      final remaining = allMedia.where((m) => !recommendations.contains(m)).toList()..shuffle();
      recommendations.addAll(remaining.take(10 - recommendations.length));
    }

    return recommendations.take(10).toList();
  }

  String explainRecommendation(MediaItem item, List<PlaybackHistoryItem> history) {
    if (item.tags.contains('synthwave')) {
      return "Because you've been listening to a lot of electronic music lately.";
    }
    return "Based on your recent listening history and vibe preferences.";
  }
}

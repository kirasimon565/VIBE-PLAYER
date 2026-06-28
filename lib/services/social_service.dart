import '../models/media_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SocialService {
  final String baseUrl = 'https://api.vibeplayer.com/v1'; // Production API URL

  Future<List<Map<String, dynamic>>> getNearbyListening(double lat, double lon) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/social/nearby?lat=$lat&lon=$lon'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> shareMood(String mood, MediaItem item) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/social/share'),
        body: json.encode({
          'mood': mood,
          'mediaId': item.id,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

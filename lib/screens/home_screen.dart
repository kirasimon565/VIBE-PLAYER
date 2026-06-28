import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/media_provider.dart';
import '../services/playback_service.dart';
import 'player_screen.dart';
import 'settings_screen.dart';
import '../models/media_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vibe Player', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
          }),
        ],
      ),
      body: Consumer<MediaProvider>(
        builder: (context, mediaProvider, child) {
          if (mediaProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () => mediaProvider.loadMedia(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Your Vibe Today'),
                  _buildHorizontalList(context, mediaProvider.trendingMedia),
                  _buildSectionHeader('Sonic Discovery'),
                  _buildHorizontalList(context, mediaProvider.allMedia.reversed.toList()),
                  _buildSectionHeader('Recent Vibes'),
                  _buildVerticalList(context, mediaProvider.recentMedia),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _playMediaAndNavigate(BuildContext context, MediaItem item) {
    final playbackService = Provider.of<PlaybackService>(context, listen: false);
    playbackService.play(item);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => const PlayerScreen(),
    ));
  }

  Widget _buildHorizontalList(BuildContext context, List<MediaItem> mediaList) {
    if (mediaList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('No media found.'),
      );
    }
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: mediaList.length,
        itemBuilder: (context, index) {
          final item = mediaList[index];
          return GestureDetector(
            onTap: () => _playMediaAndNavigate(context, item),
            child: Container(
              width: 140,
              margin: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[900],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        color: Colors.primaries[index % Colors.primaries.length].withValues(alpha: 0.5),
                      ),
                      child: const Center(child: Icon(Icons.music_note, size: 40)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(item.artist, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVerticalList(BuildContext context, List<MediaItem> mediaList) {
    if (mediaList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No recent media.'),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mediaList.length,
      itemBuilder: (context, index) {
        final item = mediaList[index];
        return ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.play_arrow),
          ),
          title: Text(item.title),
          subtitle: Text(item.artist),
          trailing: const Icon(Icons.more_vert),
          onTap: () => _playMediaAndNavigate(context, item),
        );
      },
    );
  }
}

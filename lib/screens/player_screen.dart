import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/audio/three_d_album_art.dart';
import '../widgets/audio/wave_visualizer.dart';
import '../widgets/common/custom_slider.dart';
import '../services/playback_service.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.withValues(alpha: 0.5),
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Consumer<PlaybackService>(
            builder: (context, playbackService, child) {
              final isPlaying = playbackService.isPlaying;
              final progress = playbackService.totalDuration.inMilliseconds > 0
                  ? playbackService.currentPosition.inMilliseconds / playbackService.totalDuration.inMilliseconds
                  : 0.0;

              String formatDuration(Duration d) {
                String twoDigits(int n) => n.toString().padLeft(2, '0');
                return '${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}';
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 20),
                  AlbumArt3D(
                    isPlaying: isPlaying,
                    imagePath: playbackService.currentItem?.albumArtPath,
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        Text(
                          playbackService.currentItem?.title ?? 'No Track Playing',
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          playbackService.currentItem?.artist ?? 'Unknown Artist',
                          style: TextStyle(fontSize: 18, color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  WaveVisualizer(isPlaying: isPlaying, color: Colors.purpleAccent),
                  const SizedBox(height: 20),
                  CustomSlider(
                    value: progress,
                    max: 1.0,
                    leftLabel: formatDuration(playbackService.currentPosition),
                    rightLabel: formatDuration(playbackService.totalDuration),
                    onChanged: (val) {
                      final newPosition = Duration(
                        milliseconds: (val * playbackService.totalDuration.inMilliseconds).round(),
                      );
                      playbackService.seek(newPosition);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(icon: const Icon(Icons.shuffle, color: Colors.grey), onPressed: () {}),
                        IconButton(icon: const Icon(Icons.skip_previous, size: 40), onPressed: () {}),
                        GestureDetector(
                          onTap: () {
                            if (isPlaying) {
                              playbackService.pause();
                            } else {
                              playbackService.resume();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 40,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(icon: const Icon(Icons.skip_next, size: 40), onPressed: () {}),
                        IconButton(icon: const Icon(Icons.repeat, color: Colors.grey), onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

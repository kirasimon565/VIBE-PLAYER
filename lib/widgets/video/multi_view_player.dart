import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MultiViewPlayer extends StatefulWidget {
  final VideoPlayerController? controller;
  final String mode; // 'cine-vibe', 'reality-blend', 'dream-stream', etc.

  const MultiViewPlayer({
    super.key,
    required this.controller,
    this.mode = 'cine-vibe',
  }) ;

  @override
  State<MultiViewPlayer> createState() => _MultiViewPlayerState();
}

class _MultiViewPlayerState extends State<MultiViewPlayer> {
  @override
  Widget build(BuildContext context) {
    if (widget.controller == null || !widget.controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    Widget videoWidget = AspectRatio(
      aspectRatio: widget.controller!.value.aspectRatio,
      child: VideoPlayer(widget.controller!),
    );

    // Apply effects based on mode
    if (widget.mode == 'dream-stream') {
      videoWidget = ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.purple.withValues(alpha: 0.3),
          BlendMode.overlay,
        ),
        child: videoWidget,
      );
    } else if (widget.mode == 'reality-blend') {
      // Simulate AR overlay or blend
      videoWidget = Stack(
        alignment: Alignment.center,
        children: [
          videoWidget,
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.transparent, Colors.black.withValues(alpha: 0.5)],
                radius: 1.5,
              ),
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        if (widget.controller!.value.isPlaying) {
          widget.controller!.pause();
        } else {
          widget.controller!.play();
        }
      },
      child: Container(
        color: Colors.black,
        child: Center(
          child: videoWidget,
        ),
      ),
    );
  }
}

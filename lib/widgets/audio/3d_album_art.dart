import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';

class AlbumArt3D extends StatefulWidget {
  final String? imagePath;
  final bool isPlaying;

  const AlbumArt3D({
    Key? key,
    this.imagePath,
    required this.isPlaying,
  }) : super(key: key);

  @override
  State<AlbumArt3D> createState() => _AlbumArt3DState();
}

class _AlbumArt3DState extends State<AlbumArt3D> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _rx = 0.0;
  double _ry = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    if (widget.isPlaying) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(AlbumArt3D oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _rx += details.delta.dy * 0.01;
          _ry -= details.delta.dx * 0.01;
        });
      },
      onPanEnd: (_) {
        setState(() {
          _rx = 0;
          _ry = 0;
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateX(_rx)
              ..rotateY(_ry + (widget.isPlaying ? _controller.value * 2 * pi : 0)),
            alignment: Alignment.center,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 10),
                  ),
                ],
                image: widget.imagePath != null && widget.imagePath!.isNotEmpty
                    ? DecorationImage(
                        image: widget.imagePath!.startsWith('http')
                            ? NetworkImage(widget.imagePath!) as ImageProvider
                            : FileImage(File(widget.imagePath!)),
                        fit: BoxFit.cover,
                      )
                    : null,
                gradient: widget.imagePath == null || widget.imagePath!.isEmpty
                    ? const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF03DAC6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
              ),
              child: widget.imagePath == null || widget.imagePath!.isEmpty
                  ? const Icon(Icons.music_note, size: 80, color: Colors.white)
                  : null,
            ),
          );
        },
      ),
    );
  }
}

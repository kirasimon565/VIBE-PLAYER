import 'package:flutter/material.dart';
import 'dart:math';

class WaveVisualizer extends StatefulWidget {
  final bool isPlaying;
  final Color color;

  const WaveVisualizer({
    Key? key,
    required this.isPlaying,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  State<WaveVisualizer> createState() => _WaveVisualizerState();
}

class _WaveVisualizerState extends State<WaveVisualizer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int numberOfBars = 30;
  final List<double> _heights = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..addListener(() {
        if (widget.isPlaying) {
          setState(() {
            _updateHeights();
          });
        }
      });

    if (widget.isPlaying) {
      _controller.repeat();
    }

    for (int i = 0; i < numberOfBars; i++) {
      _heights.add(20.0);
    }
  }

  @override
  void didUpdateWidget(WaveVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _controller.repeat();
      } else {
        _controller.stop();
        setState(() {
          for (int i = 0; i < numberOfBars; i++) {
            _heights[i] = 10.0;
          }
        });
      }
    }
  }

  void _updateHeights() {
    final random = Random();
    for (int i = 0; i < numberOfBars; i++) {
      _heights[i] = 10.0 + random.nextDouble() * 80.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(numberOfBars, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: 4,
            height: _heights[index],
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.8),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      ),
    );
  }
}

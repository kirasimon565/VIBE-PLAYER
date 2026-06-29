import 'package:flutter/material.dart';
import 'dart:math';

class HolographicDisplay extends StatefulWidget {
  final Widget child;

  const HolographicDisplay({super.key, required this.child}) ;

  @override
  State<HolographicDisplay> createState() => _HolographicDisplayState();
}

class _HolographicDisplayState extends State<HolographicDisplay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                Colors.cyanAccent.withValues(alpha: 0.5),
                Colors.purpleAccent.withValues(alpha: 0.5),
                Colors.cyanAccent.withValues(alpha: 0.5),
              ],
              stops: [0.0, 0.5 + sin(_controller.value * 2 * pi) * 0.5, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          blendMode: BlendMode.screen,
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}

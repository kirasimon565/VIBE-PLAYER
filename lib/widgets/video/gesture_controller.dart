import 'package:flutter/material.dart';

class VideoGestureController extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final Function(double) onHorizontalDrag;
  final Function(double) onVerticalDrag;

  const VideoGestureController({
    Key? key,
    required this.child,
    required this.onTap,
    required this.onDoubleTap,
    required this.onHorizontalDrag,
    required this.onVerticalDrag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onHorizontalDragUpdate: (details) {
        onHorizontalDrag(details.delta.dx);
      },
      onVerticalDragUpdate: (details) {
        onVerticalDrag(details.delta.dy);
      },
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

class ProjectionMapper extends StatelessWidget {
  final Widget child;
  final double distortionFactor;

  const ProjectionMapper({
    super.key,
    required this.child,
    this.distortionFactor = 0.1,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(distortionFactor)
        ..rotateY(distortionFactor),
      alignment: Alignment.center,
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:math';

class ParticleEffects extends StatefulWidget {
  final bool isPlaying;
  final Color color;

  const ParticleEffects({
    Key? key,
    required this.isPlaying,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  State<ParticleEffects> createState() => _ParticleEffectsState();
}

class _ParticleEffectsState extends State<ParticleEffects> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {
          _updateParticles();
        });
      });

    if (widget.isPlaying) {
      _controller.repeat();
    }

    for (int i = 0; i < 50; i++) {
      _particles.add(_createParticle());
    }
  }

  @override
  void didUpdateWidget(ParticleEffects oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  _Particle _createParticle() {
    return _Particle(
      x: _random.nextDouble(),
      y: _random.nextDouble(),
      speedX: (_random.nextDouble() - 0.5) * 0.02,
      speedY: (_random.nextDouble() - 0.5) * 0.02,
      size: _random.nextDouble() * 4 + 2,
      opacity: _random.nextDouble(),
    );
  }

  void _updateParticles() {
    for (var particle in _particles) {
      particle.x += particle.speedX;
      particle.y += particle.speedY;

      if (particle.x < 0 || particle.x > 1) particle.speedX *= -1;
      if (particle.y < 0 || particle.y > 1) particle.speedY *= -1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ParticlePainter(particles: _particles, color: widget.color),
      child: Container(),
    );
  }
}

class _Particle {
  double x, y, speedX, speedY, size, opacity;
  _Particle({required this.x, required this.y, required this.speedX, required this.speedY, required this.size, required this.opacity});
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final Color color;

  _ParticlePainter({required this.particles, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (var particle in particles) {
      paint.color = color.withOpacity(particle.opacity);
      canvas.drawCircle(
        Offset(particle.x * size.width, particle.y * size.height),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

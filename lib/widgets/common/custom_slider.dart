import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final double max;
  final ValueChanged<double>? onChanged;
  final String leftLabel;
  final String rightLabel;

  const CustomSlider({
    super.key,
    required this.value,
    required this.max,
    this.onChanged,
    this.leftLabel = '',
    this.rightLabel = '',
  }) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
          ),
          child: Slider(
            value: value.clamp(0.0, max > 0 ? max : 1.0),
            max: max > 0 ? max : 1.0,
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(leftLabel, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(rightLabel, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}

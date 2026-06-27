import 'package:flutter/material.dart';

class EqualizerControls extends StatefulWidget {
  const EqualizerControls({Key? key}) : super(key: key);

  @override
  State<EqualizerControls> createState() => _EqualizerControlsState();
}

class _EqualizerControlsState extends State<EqualizerControls> {
  List<double> frequencies = [0.5, 0.7, 0.4, 0.6, 0.8];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(frequencies.length, (index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: Slider(
                value: frequencies[index],
                onChanged: (val) {
                  setState(() {
                    frequencies[index] = val;
                  });
                },
              ),
            ),
            Text('${(index + 1) * 60}Hz', style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        );
      }),
    );
  }
}

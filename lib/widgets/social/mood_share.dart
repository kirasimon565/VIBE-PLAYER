import 'package:flutter/material.dart';

class MoodShareWidget extends StatelessWidget {
  final String mood;
  final VoidCallback onShare;

  const MoodShareWidget({
    super.key,
    required this.mood,
    required this.onShare,
  }) ;

  @override
  Widget build(BuildContext context) {
    IconData moodIcon;
    Color moodColor;

    switch (mood) {
      case 'energetic':
        moodIcon = Icons.bolt;
        moodColor = Colors.orange;
        break;
      case 'chill':
        moodIcon = Icons.ac_unit;
        moodColor = Colors.blue;
        break;
      case 'focus':
        moodIcon = Icons.center_focus_strong;
        moodColor = Colors.green;
        break;
      default:
        moodIcon = Icons.mood;
        moodColor = Colors.purple;
    }

    return InkWell(
      onTap: onShare,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: moodColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: moodColor.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(moodIcon, color: moodColor, size: 20),
            const SizedBox(width: 8),
            Text(
              'Share $mood vibe',
              style: TextStyle(color: moodColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

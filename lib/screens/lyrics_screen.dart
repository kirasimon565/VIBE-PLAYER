import 'package:flutter/material.dart';

class LyricsScreen extends StatelessWidget {
  const LyricsScreen({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Lyrics')),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ListView(
          children: const [
            Text('Neon lights in the distance', style: TextStyle(fontSize: 24, color: Colors.grey)),
            SizedBox(height: 16),
            Text('Synthesizers playing loud', style: TextStyle(fontSize: 24, color: Colors.grey)),
            SizedBox(height: 16),
            Text('We ride into the night', style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Cyberpunk city dreams', style: TextStyle(fontSize: 24, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

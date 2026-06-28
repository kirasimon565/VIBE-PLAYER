import 'package:flutter/material.dart';
import '../widgets/social/mood_share.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Social Vibe')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Share your vibe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                MoodShareWidget(mood: 'energetic', onShare: (){}),
                MoodShareWidget(mood: 'chill', onShare: (){}),
                MoodShareWidget(mood: 'focus', onShare: (){}),
                MoodShareWidget(mood: 'melancholy', onShare: (){}),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Vibe Rooms', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(backgroundColor: Colors.purple),
                    title: Text('Room ${index + 1}'),
                    subtitle: const Text('Listening together...'),
                    trailing: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                      child: const Text('Join'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

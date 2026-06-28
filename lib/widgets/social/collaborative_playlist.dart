import 'package:flutter/material.dart';
import '../../models/playlist.dart';

class CollaborativePlaylistView extends StatelessWidget {
  final Playlist playlist;

  const CollaborativePlaylistView({
    super.key,
    required this.playlist,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                playlist.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Chip(
                label: Text('Collaborative'),
                backgroundColor: Colors.purpleAccent,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: playlist.items.length,
            itemBuilder: (context, index) {
              final item = playlist.items[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.primaries[index % Colors.primaries.length],
                  child: Text(item.title[0]),
                ),
                title: Text(item.title),
                subtitle: Text('Added by User ${index + 1}'),
                trailing: IconButton(
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                  onPressed: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../models/media_item.dart';

class MediaBrowser extends StatelessWidget {
  final List<MediaItem> items;
  final Function(MediaItem) onSelect;

  const MediaBrowser({
    super.key,
    required this.items,
    required this.onSelect,
  }) ;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.isVideo ? Icons.video_library : Icons.music_note),
          ),
          title: Text(item.title),
          subtitle: Text(item.artist),
          onTap: () => onSelect(item),
        );
      },
    );
  }
}

import 'media_item.dart';

class Playlist {
  final String id;
  final String name;
  final String description;
  final String? coverPath;
  final List<MediaItem> items;
  final bool isCollaborative;
  final bool isSmart;

  Playlist({
    required this.id,
    required this.name,
    this.description = '',
    this.coverPath,
    required this.items,
    this.isCollaborative = false,
    this.isSmart = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'coverPath': coverPath,
        'items': items.map((e) => e.toJson()).toList(),
        'isCollaborative': isCollaborative,
        'isSmart': isSmart,
      };

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        id: json['id'],
        name: json['name'],
        description: json['description'] ?? '',
        coverPath: json['coverPath'],
        items: (json['items'] as List).map((e) => MediaItem.fromJson(e)).toList(),
        isCollaborative: json['isCollaborative'] ?? false,
        isSmart: json['isSmart'] ?? false,
      );
}

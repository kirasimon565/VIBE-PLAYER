class MediaItem {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String path;
  final Duration duration;
  final bool isVideo;
  final String? albumArtPath;
  final List<String> tags;
  final double bpm;

  MediaItem({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.path,
    required this.duration,
    this.isVideo = false,
    this.albumArtPath,
    this.tags = const [],
    this.bpm = 120.0,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'artist': artist,
        'album': album,
        'path': path,
        'duration': duration.inMilliseconds,
        'isVideo': isVideo,
        'albumArtPath': albumArtPath,
        'tags': tags,
        'bpm': bpm,
      };

  factory MediaItem.fromJson(Map<String, dynamic> json) => MediaItem(
        id: json['id'],
        title: json['title'],
        artist: json['artist'],
        album: json['album'],
        path: json['path'],
        duration: Duration(milliseconds: json['duration']),
        isVideo: json['isVideo'] ?? false,
        albumArtPath: json['albumArtPath'],
        tags: List<String>.from(json['tags'] ?? []),
        bpm: json['bpm'] ?? 120.0,
      );
}

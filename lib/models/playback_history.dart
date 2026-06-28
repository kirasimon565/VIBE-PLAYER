class PlaybackHistoryItem {
  final String mediaId;
  final DateTime playedAt;
  final Duration durationPlayed;
  final String context; // e.g., 'playlist', 'album', 'search'

  PlaybackHistoryItem({
    required this.mediaId,
    required this.playedAt,
    required this.durationPlayed,
    this.context = 'unknown',
  });

  Map<String, dynamic> toJson() => {
    'mediaId': mediaId,
    'playedAt': playedAt.toIso8601String(),
    'durationPlayed': durationPlayed.inMilliseconds,
    'context': context,
  };

  factory PlaybackHistoryItem.fromJson(Map<String, dynamic> json) => PlaybackHistoryItem(
    mediaId: json['mediaId'],
    playedAt: DateTime.parse(json['playedAt']),
    durationPlayed: Duration(milliseconds: json['durationPlayed']),
    context: json['context'] ?? 'unknown',
  );
}

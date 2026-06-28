class UserPreferences {
  final bool enableSmartRecommendations;
  final bool enableMotionControls;
  final bool useHapticFeedback;
  final String defaultVisualizer;
  final String defaultMood;
  final Map<String, dynamic> equalizerSettings;

  UserPreferences({
    this.enableSmartRecommendations = true,
    this.enableMotionControls = true,
    this.useHapticFeedback = true,
    this.defaultVisualizer = 'wave',
    this.defaultMood = 'chill',
    this.equalizerSettings = const {},
  });

  Map<String, dynamic> toJson() => {
    'enableSmartRecommendations': enableSmartRecommendations,
    'enableMotionControls': enableMotionControls,
    'useHapticFeedback': useHapticFeedback,
    'defaultVisualizer': defaultVisualizer,
    'defaultMood': defaultMood,
    'equalizerSettings': equalizerSettings,
  };

  factory UserPreferences.fromJson(Map<String, dynamic> json) => UserPreferences(
    enableSmartRecommendations: json['enableSmartRecommendations'] ?? true,
    enableMotionControls: json['enableMotionControls'] ?? true,
    useHapticFeedback: json['useHapticFeedback'] ?? true,
    defaultVisualizer: json['defaultVisualizer'] ?? 'wave',
    defaultMood: json['defaultMood'] ?? 'chill',
    equalizerSettings: json['equalizerSettings'] ?? {},
  );
}

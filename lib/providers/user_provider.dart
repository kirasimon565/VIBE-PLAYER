import 'package:flutter/foundation.dart';
import '../models/user_preferences.dart';

class UserProvider extends ChangeNotifier {
  UserPreferences _preferences = UserPreferences();

  UserPreferences get preferences => _preferences;

  void updatePreferences(UserPreferences newPrefs) {
    _preferences = newPrefs;
    notifyListeners();
  }

  void updateVisualizer(String visualizer) {
    _preferences = UserPreferences(
      enableSmartRecommendations: _preferences.enableSmartRecommendations,
      enableMotionControls: _preferences.enableMotionControls,
      useHapticFeedback: _preferences.useHapticFeedback,
      defaultVisualizer: visualizer,
      defaultMood: _preferences.defaultMood,
      equalizerSettings: _preferences.equalizerSettings,
    );
    notifyListeners();
  }
}

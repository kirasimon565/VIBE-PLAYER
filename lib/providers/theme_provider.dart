import 'package:flutter/material.dart';
import '../config/theme_config.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeData _themeData = ThemeConfig.darkTheme;
  Color _dynamicColor = Colors.transparent;

  ThemeData get themeData => _themeData;
  Color get dynamicColor => _dynamicColor;

  void updateDynamicColor(Color color) {
    _dynamicColor = color;
    notifyListeners();
  }
}

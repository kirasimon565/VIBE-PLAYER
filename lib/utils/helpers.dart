import 'dart:math';

class Helpers {
  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString() + Random().nextInt(1000).toString();
  }

  static double normalize(double value, double min, double max) {
    return (value - min) / (max - min);
  }
}

import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static Future<bool> requestMediaPermissions() async {
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.audio,
      Permission.videos,
      Permission.photos,
    ].request();

    // For older Android versions
    if (statuses[Permission.audio] == PermissionStatus.denied &&
        statuses[Permission.videos] == PermissionStatus.denied) {
      final storageStatus = await Permission.storage.request();
      return storageStatus.isGranted;
    }

    return statuses.values.any((status) => status.isGranted);
  }

  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }
}

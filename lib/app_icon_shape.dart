import 'dart:ui';

import 'app_icon_shape_platform_interface.dart';

class AppIconShape {
  /// Returns the platform's name and version
  /// e.g. Android 12
  static Future<String?> getPlatformVersion() {
    return AppIconShapePlatform.instance.getPlatformVersion();
  }

  /// On Android, returns
  static Future<Path?> getAppIconMask() {
    return AppIconShapePlatform.instance.getAppIconMask();
  }
}

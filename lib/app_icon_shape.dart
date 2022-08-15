import 'dart:ui';

import 'app_icon_shape_platform_interface.dart';

class AppIconShape {
  static Future<String?> getPlatformVersion() {
    return AppIconShapePlatform.instance.getPlatformVersion();
  }

  static Future<Path?> getAppIconMask() {
    return AppIconShapePlatform.instance.getAppIconMask();
  }
}

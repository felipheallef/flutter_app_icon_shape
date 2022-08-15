import 'dart:ui';

import 'app_icon_shape_platform_interface.dart';

class AppIconShape {
  Future<String?> getPlatformVersion() {
    return AppIconShapePlatform.instance.getPlatformVersion();
  }

  Future<Path?> getAppIconMask() {
    return AppIconShapePlatform.instance.getAppIconMask();
  }
}

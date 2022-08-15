import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_drawing/path_drawing.dart';

import 'app_icon_shape_platform_interface.dart';

/// An implementation of [AppIconShapePlatform] that uses method channels.
class MethodChannelAppIconShape extends AppIconShapePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app_icon_shape');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<Path?> getAppIconMask() async {
    final path = await methodChannel.invokeMethod<String>('getIconMask');
    if (path != null) {
      return parseSvgPathData(path);
    }
    return null;
  }
}

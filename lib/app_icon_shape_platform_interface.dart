import 'dart:ui';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_icon_shape_method_channel.dart';

abstract class AppIconShapePlatform extends PlatformInterface {
  /// Constructs a AppIconShapePlatform.
  AppIconShapePlatform() : super(token: _token);

  static final Object _token = Object();

  static AppIconShapePlatform _instance = MethodChannelAppIconShape();

  /// The default instance of [AppIconShapePlatform] to use.
  ///
  /// Defaults to [MethodChannelAppIconShape].
  static AppIconShapePlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppIconShapePlatform] when
  /// they register themselves.
  static set instance(AppIconShapePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Path?> getAppIconMask() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

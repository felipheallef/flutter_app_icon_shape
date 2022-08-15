import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:app_icon_shape/app_icon_shape.dart';
import 'package:app_icon_shape/app_icon_shape_platform_interface.dart';
import 'package:app_icon_shape/app_icon_shape_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppIconShapePlatform 
    with MockPlatformInterfaceMixin
    implements AppIconShapePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<Path?> getAppIconMask() => Future.value(Path());
}

void main() {
  final AppIconShapePlatform initialPlatform = AppIconShapePlatform.instance;

  test('$MethodChannelAppIconShape is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAppIconShape>());
  });

  test('getPlatformVersion', () async {
    MockAppIconShapePlatform fakePlatform = MockAppIconShapePlatform();
    AppIconShapePlatform.instance = fakePlatform;
  
    expect(await AppIconShape.getPlatformVersion(), '42');
  });
}

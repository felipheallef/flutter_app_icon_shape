#import "AppIconShapePlugin.h"
#if __has_include(<app_icon_shape/app_icon_shape-Swift.h>)
#import <app_icon_shape/app_icon_shape-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "app_icon_shape-Swift.h"
#endif

@implementation AppIconShapePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppIconShapePlugin registerWithRegistrar:registrar];
}
@end

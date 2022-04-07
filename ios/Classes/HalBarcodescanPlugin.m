#import "HalBarcodescanPlugin.h"
#if __has_include(<hal_barcodescan/hal_barcodescan-Swift.h>)
#import <hal_barcodescan/hal_barcodescan-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "hal_barcodescan-Swift.h"
#endif

@implementation HalBarcodescanPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHalBarcodescanPlugin registerWithRegistrar:registrar];
}
@end

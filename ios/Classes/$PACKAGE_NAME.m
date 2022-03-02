#import "$PLUGIN_NAME.h"
#if __has_include(<$PACKAGE_NAME/$PACKAGE_NAME-Swift.h>)
#import <$PACKAGE_NAME/PACKAGE_NAME-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "$PACKAGE_NAME-Swift.h"
#endif

@implementation $PLUGIN_NAME
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [Swift$PLUGIN_NAME registerWithRegistrar:registrar];
}
@end

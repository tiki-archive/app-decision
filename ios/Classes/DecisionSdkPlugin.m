#import "DecisionSdkPlugin.h"
#if __has_include(<decision_sdk/decision_sdk-Swift.h>)
#import <decision_sdk/decision_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "decision_sdk-Swift.h"
#endif

@implementation DecisionSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDecisionSdkPlugin registerWithRegistrar:registrar];
}
@end

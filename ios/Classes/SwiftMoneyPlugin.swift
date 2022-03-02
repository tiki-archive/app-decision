import Flutter
import UIKit

public class Swift$PLUGIN_NAME: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "$PACKAGE_NAME", binaryMessenger: registrar.messenger())
    let instance = Swift$PLUGIN_NAME()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}

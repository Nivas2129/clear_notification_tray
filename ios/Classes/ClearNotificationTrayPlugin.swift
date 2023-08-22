import Flutter
import UIKit

public class ClearNotificationTrayPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "notificationTrayChannel", binaryMessenger: registrar.messenger())
        let instance = ClearNotificationTrayPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "clear" {
            channelMethodClearAllNotifications(result: result)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func channelMethodClearAllNotifications(result: @escaping FlutterResult) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.applicationIconBadgeNumber = 0
            let center = UNUserNotificationCenter.current()
            center.removeAllDeliveredNotifications()
            result(nil) // Success, so returns nil
        } else {
            let currentVersion: [String: Any] = [
                "iosVersion": UIDevice.current.systemVersion
            ]
            let error = FlutterError(code: "UNSUPPORTED_VERSION", message: "Clearing notifications is only supported on iOS 10.0 and later", details: currentVersion)
            result(error) // Returns error for unsupported version
        }
    }
}

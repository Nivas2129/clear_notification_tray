import Flutter
import UIKit

public class ClearNotificationTrayPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "notificationTrayChannel", binaryMessenger: registrar.messenger())
        let instance = ClearNotificationTrayPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            case "clear":
                channelMethodClearAllNotifications(result: result)
            case "clearByTag":
                channelMethodClearNotificationByTag(call: call, result: result)
            default:
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

    private func channelMethodClearNotificationByTag(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.applicationIconBadgeNumber = 0
            let center = UNUserNotificationCenter.current()
            let args = call.arguments as! Dictionary<String, String>
            let tag = args["tag"]! as String
            center.removeDeliveredNotifications(withIdentifiers: [])
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

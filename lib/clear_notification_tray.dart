import 'dart:async';
import 'package:clear_notification_tray/clear_notification_exception.dart';
import 'package:flutter/services.dart';

class ClearNotificationTray {
  static const MethodChannel _channel =
      MethodChannel(NotificationTrayConstants.channelName);

  /// Clears all received push notifications in the app.
  ///
  /// In Android, this removes icons from the status bar and notification from the drawer.
  ///
  /// In iOS, notifications are removed from the notification center and sets the iOS applicationIconBadgeNumber to 0.
  ///
  /// Note: Other apps push notifications are not affected.
  static Future<void> clear() async {
    try {
      await _channel.invokeMethod(NotificationTrayConstants.methodName);
    } catch (e) {
      throw ClearNotificationTrayException(message: e.toString());
    }
  }
}

class NotificationTrayConstants {
  static const channelName = 'notificationTrayChannel';
  static const methodName = 'clear';
}

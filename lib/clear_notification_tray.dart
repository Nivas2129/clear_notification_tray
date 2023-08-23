import 'dart:async';
import 'package:clear_notification_tray/clear_notification_exception.dart';
import 'package:flutter/services.dart';

class ClearNotificationTray {
  static const MethodChannel _channel = MethodChannel(NotificationTrayConstants.channelName);

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

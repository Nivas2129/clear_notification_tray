import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';

class ClearNotificationTray {
  static const MethodChannel _channel = MethodChannel(NotificationTrayConstants.channelName);

  static Future<void> clear() async {
    try{
      await _channel.invokeMethod(NotificationTrayConstants.methodName);
    } on PlatformException catch (e){
      log(e.message!);
      rethrow;
    }
  }
}

class NotificationTrayConstants{
  static const channelName = 'notificationTrayChannel';
  static const methodName = 'clear';
}
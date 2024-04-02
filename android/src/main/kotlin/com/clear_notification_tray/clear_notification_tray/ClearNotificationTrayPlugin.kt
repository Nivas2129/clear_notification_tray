package com.clear_notification_tray.clear_notification_tray

import android.content.Context
import android.app.NotificationManager
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ClearNotificationTrayPlugin */
class ClearNotificationTrayPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "notificationTrayChannel")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "clear" -> channelMethodClearAllNotifications(result)
      "clearByTag" -> channelMethodClearNotificationByTag(call, result)
      else -> result.notImplemented()
    }
  }


  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun channelMethodClearAllNotifications(@NonNull result: Result) {
    try {
      val notificationManager: NotificationManager =
        context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
      notificationManager.cancelAll()
      result.success(true)
    } catch (e: Exception) {
      result.error("Cannot clear the notification tray", e.message, e)
    }
  }

  private fun channelMethodClearNotificationByTag(@NonNull call: MethodCall, @NonNull result: Result) {
    try {
        val tagToCancel = call.argument<String>("tag")

        if (tagToCancel != null) {
            val notificationManager: NotificationManager =
                    context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

            val activeNotifications = notificationManager.activeNotifications

            for (notification in activeNotifications) {
                val id = notification.id
                val tag = notification.tag ?: "null"

                if (tag == tagToCancel) {
                    notificationManager.cancel(tag, id)
                }
            }

            result.success(true)
        } else {
            result.error("Invalid Arguments", "Tag argument is missing or null", null)
        }
    } catch (e: Exception) {
        result.error("Cannot clear the notification tray", e.message, e)
    }
}
}


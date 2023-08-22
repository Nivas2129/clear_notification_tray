# clear_notification_tray

A Flutter plugin to dismiss notifications in Android and iOS. 

## How to use the plugin
The `clear` method can be called  to clear all the notifications received by your app.<br />
Upon receiving the push notifications, iOS applications display a red badge with notification count inside. It also dismisses this badge count.<br />


To clear all notifications when the app is started, call the `clear` method in your `main` method. 

```dart
void main() {
  runApp(MyApp());
  ClearNotificationTray.clear();
}
```

## iOS compatibility
This plugin is only compatible for clearing notifications in iOS devices running with iOS version `10.0` or above.<br />
The methods will return a PlatformException for iOS version less than `10.0` without dismissing notifications.<br />
The plugin uses `UNUserNotificationCenter API` to clear notification and reset the badge number on the app icon that was introduced in iOS version 10.0.<br />
Before iOS 10.0, there wasn't a  standardized way to programmatically clear notifications or reset the badge number.<br />





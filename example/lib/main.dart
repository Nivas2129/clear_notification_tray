import 'package:clear_notification_tray/clear_notification_tray.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example for clearing notifications'),
        ),
        body:  Center(
          child: ElevatedButton(
            onPressed: () =>
              ClearNotificationTray.clear(),
            child: const Text(
              'Clear All Notifications',
            ),
          ),
        ),
      ),
    );
  }
}

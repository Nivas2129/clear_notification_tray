class ClearNotificationTrayException implements Exception {
  final String message;

  ClearNotificationTrayException({required this.message});

  @override
  String toString() => message.toString();
}

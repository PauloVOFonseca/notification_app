import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_app/app/another_page.dart';
import 'package:notification_app/app/navigation_service.dart';

class FlutterLocalNotification {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void initialize() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  Future<dynamic> onSelectNotification(payload) async {
    if (payload != null) {
      NavigationService.instance.navigationKey.currentState?.push(
        MaterialPageRoute(builder: (context) => const AnotherPage()),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_app/app/encode_image.dart';
import 'package:notification_app/app/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

Future<void> showNotification({
  required String channelId,
  required String title,
  required String bodyText,
  String? payload,
  bool isScheduled = false,
  TZDateTime? scheduledDate,
  bool isNotificationPermanent = false,
}) async {
  FlutterLocalNotification notification = FlutterLocalNotification();
  notification.initialize();

  final String largeIcon = await base64encodedImage(
      'https://assets.pokemon.com/assets/cms2/img/pokedex/full/114.png');

  final android = AndroidNotificationDetails(
    'testeId',
    'testeName',
    styleInformation: BigTextStyleInformation(bodyText),
    color: Colors.purple,
    priority: Priority.high,
    importance: Importance.max,
    ongoing: isNotificationPermanent,
    largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
  );

  const iOS = IOSNotificationDetails();
  final platform = NotificationDetails(android: android, iOS: iOS);

  if (!isScheduled) {
    await notification.flutterLocalNotificationsPlugin.show(
      channelId.hashCode,
      title,
      bodyText,
      platform,
      payload: payload,
    );
  } else {
    await notification.flutterLocalNotificationsPlugin.zonedSchedule(
      channelId.hashCode,
      title,
      bodyText,
      scheduledDate!,
      platform,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}

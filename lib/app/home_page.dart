import 'package:flutter/material.dart';
import 'package:notification_app/app/encode_image.dart';
import 'package:notification_app/app/flutter_local_notifications.dart';
import 'package:notification_app/app/show_notification.dart';
import 'package:timezone/timezone.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotification notification = FlutterLocalNotification();

  @override
  void initState() {
    notification.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => callNotification(),
              child: const Text('Teste notificação básica'),
            ),
            ElevatedButton(
              onPressed: () => callNotificationWithPayload(),
              child: const Text('Teste notificação com navegação'),
            ),
            ElevatedButton(
              onPressed: () => callNotificationWithSchedule(),
              child: const Text('Teste notificação agendada'),
            ),
            ElevatedButton(
              onPressed: () => callPermanentNotification(),
              child: const Text('Teste notificação fixa'),
            ),
            ElevatedButton(
              onPressed: () => clear(),
              child: const Text('Apagar notificações'),
            ),
          ],
        ),
      ),
    );
  }

  callNotification() async {
    await showNotification(
      bodyText: 'Test Basic Notification',
      channelId: '1231',
      title: 'Basic',
      largeIcon: await base64encodedImage(
          'https://assets.pokemon.com/assets/cms2/img/pokedex/full/114.png'),
    );
  }

  callNotificationWithPayload() async {
    await showNotification(
        bodyText: 'Test on tap Notification',
        channelId: '1232',
        title: 'Notificação com payload',
        payload: 'Notificação foi clicada');
  }

  callNotificationWithSchedule() async {
    await showNotification(
      bodyText: 'Essa foi uma notificação agendada',
      channelId: '1233',
      title: 'Notificação agendada',
      isScheduled: true,
      scheduledDate: TZDateTime.now(local).add(const Duration(seconds: 5)),
    );
  }

  callPermanentNotification() async {
    await showNotification(
      bodyText: 'Test Permanent Notification',
      channelId: '1234',
      title: 'Permanent notification',
      isNotificationPermanent: true,
    );
  }

  clear() {
    FlutterLocalNotification notification = FlutterLocalNotification();
    notification.initialize();
    notification.flutterLocalNotificationsPlugin.cancelAll();
  }
}

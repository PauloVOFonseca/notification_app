import 'package:flutter/material.dart';
import 'package:notification_app/app/home_page.dart';
import 'package:notification_app/app/navigation_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: NavigationService.instance.navigationKey,
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

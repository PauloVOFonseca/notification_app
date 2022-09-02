import 'package:flutter/material.dart';
import 'package:notification_app/app/app_widget.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("America/Bahia"));
  runApp(const MyApp());
}

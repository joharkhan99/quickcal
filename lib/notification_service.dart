import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@drawable/ic_stat_calendar_today');
    // Initialize native Ios Notifications
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    tz.initializeTimeZones();
  }

  void showNotificationAndroid(String title, String value) async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      channelDescription: 'Channel Description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    int notification_id = 1;
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(notification_id, title, value, notificationDetails, payload: 'Not present');
  }

  Future scheduleNotification(String body, String bigText, String contentTitle, DateTime notificationTime) async {
    int id = Random().nextInt(10000);
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Your Event Reminder',
        body,
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 15)),
        tz.TZDateTime.from(notificationTime, tz.local),
        NotificationDetails(
            android: AndroidNotificationDetails(
          'quickcalendar_channel_id',
          'Quick Calendar Channel Name',
          channelDescription: 'Quick Calendar Channel Description',
          importance: Importance.high,
          priority: Priority.high,
          enableVibration: true,
          playSound: true,
          styleInformation: BigTextStyleInformation(
            bigText,
            htmlFormatBigText: true,
            contentTitle: contentTitle,
          ),
        )),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
      return id;
    } catch (e) {
      print("Error at zonedScheduleNotification----------------------------$e");
      return -1;
    }
  }
}

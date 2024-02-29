import 'dart:math';
import 'dart:typed_data';

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

    tz.initializeTimeZones(); // <---- Make this change.
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

  Future showTimedNotification() async {
    int id = Random().nextInt(10000);
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Your Event Reminder',
        'Interview with Simpalm at 9:00 AM',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 15)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'quickcalendar_channel_id',
          'Quick Calendar Channel Name',
          channelDescription: 'your channel description',
          importance: Importance.high,
          priority: Priority.high,
          enableVibration: true,
          playSound: true,
          styleInformation: BigTextStyleInformation(
            'Date: 12/12/2021<br>Time: 9:00 AM-10:00 AM<br>Location: Simpalm Office<br>Notes: Interview with Simpalm',
            htmlFormatBigText: true,
            contentTitle: 'Interview with Simpalm',
          ),
        )),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
      print("It happened");
      return id;
    } catch (e) {
      print("Error at zonedScheduleNotification----------------------------$e");
      return -1;
    }
  }

  Future zonedScheduleNotification(String note, DateTime date, occ) async {
    // IMPORTANT!!
    //tz.initializeTimeZones(); --> call this before using tz.local (ideally put it in your init state)

    int id = Random().nextInt(10000);
    print(date.toString());
    print(tz.TZDateTime.parse(tz.local, date.toString()).toString());
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        occ,
        note,
        tz.TZDateTime.parse(tz.local, date.toString()),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id', 'your channel name',
            channelDescription: 'your channel description',
            // largeIcon: DrawableResourceAndroidBitmap("printo"),
            icon: "ic_stat_calendar_today",
            // playSound: true,
            // sound: RawResourceAndroidNotificationSound('bell_sound'),
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
      return id;
    } catch (e) {
      print("Error at zonedScheduleNotification----------------------------$e");
      return -1;
    }
  }
}

// void showNotificationIos(String title, String value) async {
//     const IOSNotificationDetails iOSPlatformChannelSpecifics =
//     IOSNotificationDetails(
//         presentAlert: bool?,  // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
//         presentBadge: bool?,  // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
//         presentSound: bool?,  // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
//         sound: String?,  // Specifics the file path to play (only from iOS 10 onwards)
//         badgeNumber: int?, // The application's icon badge number
//         attachments: List<IOSNotificationAttachment>?, (only from iOS 10 onwards)
//         subtitle: String?, //Secondary description  (only from iOS 10 onwards)
//         threadIdentifier: String? (only from iOS 10 onwards)
//    );

  //   int notification_id = 1;

  // const NotificationDetails platformChannelSpecifics =
  //     NotificationDetails(iOS: iOSPlatformChannelSpecifics);

  //   await flutterLocalNotificationsPlugin
  //       .show(notification_id, title, value, notificationDetails, payload: 'Not present');
  // }


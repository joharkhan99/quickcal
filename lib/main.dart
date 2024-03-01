import 'package:flutter/material.dart';
import 'package:quickcal/notification_service.dart';
import 'package:quickcal/pages/create_task_page.dart';
import 'package:quickcal/pages/home_page.dart';
import 'package:quickcal/pages/welcome_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // initialize the notification service
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService().init();

  // init the hive
  await Hive.initFlutter();
  // open the box
  await Hive.openBox('tasksbox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/home': (context) => const HomePage(),
        '/create-task': (context) => CreateTaskPage(selectedDate: DateTime.now(), handleDateCardClick: () => ()),
      },
      theme: ThemeData(
        fontFamily: 'Roboto',
        // primary color is black
        primaryColor: Colors.black,
        colorScheme: const ColorScheme.light(primary: Colors.black),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
    );
  }
}

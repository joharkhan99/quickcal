import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quickcal/pages/home_page.dart';
import 'package:quickcal/pages/welcome_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Widget _getInitialRoute() {
    final settingsBox = Hive.box('settingsbox');
    final hasSeenWelcome = settingsBox.get('hasSeenWelcome', defaultValue: false);

    if (hasSeenWelcome) {
      return const HomePage();
    } else {
      return const WelcomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => _getInitialRoute(),
        ),
      ),
    );

    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 44, 44, 44), // #000000
            Color.fromARGB(255, 19, 22, 22), // #2D3436
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "QuickCal",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Your friendly calendar app",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(153, 255, 255, 255),
                decoration: TextDecoration.none,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  /* list of slides */
  final List slides = [
    {
      'title': 'QuickCal',
      'description':
          'QuickCal is a calandar app that allows you to add, edit, and delete events.',
      'imageUrl': 'lib/assets/slides/s1.png',
    },
    {
      'title': 'QuickCal',
      'description':
          'QuickCal is a simple calculator app that allows you to perform basic arithmetic operations.',
      'imageUrl': 'lib/assets/slides/s2.png',
    },
    {
      'title': 'QuickCal',
      'description':
          'QuickCal is a simple calculator app that allows you to perform basic arithmetic operations.',
      'imageUrl': 'lib/assets/slides/s3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              slides[0]['imageUrl'],
              width: double.infinity,
              height: 250.0,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Welcome to QuickCal!',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 30.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'I provide essential stuff for your ui designs every tuesday!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Next',
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

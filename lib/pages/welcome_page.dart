import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quickcal/components/slides/slide.dart';
import 'package:quickcal/components/slides/slide_bottom_buttons.dart';
import 'package:quickcal/components/slides/slide_nav_dots.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  /* list of slides */
  final List slides = [
    {
      'title': 'Welcome to QuickCal!',
      'description': 'A user-friendly calendar app. Stay on top of your schedule, appointments, and events effortlessly.',
      'imageUrl': 'lib/assets/slides/s1.png',
    },
    {
      'title': 'Discover Powerful Features',
      'description': 'Explore a range of powerful features designed to make your life simpler. From intuitive event creation to seamless navigation.',
      'imageUrl': 'lib/assets/slides/s2.png',
    },
    {
      'title': 'Get Started Now',
      'description': 'Ready to transform the way you manage your time? Get started now to unlock the full potential of our app.',
      'imageUrl': 'lib/assets/slides/s3.png',
    },
  ];
  int currentPage = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    // check if has seen welcome
    final settingsBox = Hive.box('settingsbox');
    final hasSeenWelcome = settingsBox.get('hasSeenWelcome', defaultValue: false);

    Future.delayed(Duration.zero, () {
      if (hasSeenWelcome) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller,
                itemCount: slides.length,
                pageSnapping: true,
                onPageChanged: (page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                itemBuilder: (context, slideIndex) {
                  return Slide(
                    slide: slides[slideIndex],
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // nav dots
                  SlideNavDots(currentPage: currentPage, totalSlides: slides.length),
                  const SizedBox(height: 40.0),
                  SlideBottomButtons(
                    currentPage: currentPage,
                    totalSlides: slides.length,
                    controller: _controller,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quickcal/components/slides/slide.dart';

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
      'description':
          'A user-friendly calendar app. Stay on top of your schedule, appointments, and events effortlessly.',
      'imageUrl': 'lib/assets/slides/s1.png',
    },
    {
      'title': 'Discover Powerful Features',
      'description':
          'Explore a range of powerful features designed to make your life simpler. From intuitive event creation to seamless navigation.',
      'imageUrl': 'lib/assets/slides/s2.png',
    },
    {
      'title': 'Get Started Now',
      'description':
          'Ready to transform the way you manage your time? Get started now to unlock the full potential of our app.',
      'imageUrl': 'lib/assets/slides/s3.png',
    },
  ];
  int currentPage = 0;
  final PageController _controller = PageController(initialPage: 0);

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
                  // bottom part
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: currentPage == 0
                              ? Colors.black
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: currentPage == 1
                              ? Colors.black
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: currentPage == 2
                              ? Colors.black
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ],
                  ),
                  //
                  const SizedBox(height: 40.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(118, 46, 43, 45),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => {
                          if (currentPage < slides.length - 1)
                            {
                              _controller.animateToPage(currentPage + 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut),
                            }
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

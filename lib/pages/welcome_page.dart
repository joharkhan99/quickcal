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
  int currentPage = 0;
  final PageController _controller = PageController(initialPage: 0);
  // function to change the page

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
                itemBuilder: (context, pagePosition) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          slides[0]['imageUrl'],
                          height: 220.0,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                        const SizedBox(height: 30.0),
                        Text(
                          slides[0]['title'],
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          slides[0]['description'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(164, 46, 43, 45),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
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
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () => {
                          if (currentPage < slides.length - 1)
                            {
                              _controller.animateToPage(currentPage + 1,
                                  duration: Duration(milliseconds: 500),
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

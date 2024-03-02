import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SlideBottomButtons extends StatefulWidget {
  final int currentPage;
  final int totalSlides;
  final PageController controller;

  const SlideBottomButtons({
    super.key,
    required this.currentPage,
    required this.totalSlides,
    required this.controller,
  });

  @override
  State<SlideBottomButtons> createState() => _SlideBottomButtonsState();
}

class _SlideBottomButtonsState extends State<SlideBottomButtons> {
  bool isLastSlide = false;

  void handleNextSlide() {
    if (widget.currentPage < widget.totalSlides - 1) {
      widget.controller.animateToPage(
        widget.currentPage + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    if (widget.currentPage + 1 == widget.totalSlides - 1) {
      setState(() {
        isLastSlide = true;
      });
    }
  }

  void handleSkip(BuildContext context) {
    Hive.box('settingsbox').put('hasSeenWelcome', true);
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
          onPressed: () => handleSkip(context),
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            backgroundColor: Colors.black,
            shape: isLastSlide
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  )
                : const CircleBorder(),
          ),
          onPressed: () => isLastSlide ? handleSkip(context) : handleNextSlide(),
          child: isLastSlide
              ? const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ),
        ),
      ],
    );
  }
}

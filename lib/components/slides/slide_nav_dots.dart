import 'package:flutter/material.dart';

class SlideNavDots extends StatelessWidget {
  final int currentPage;
  final int totalSlides;
  const SlideNavDots(
      {super.key, required this.currentPage, required this.totalSlides});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalSlides,
        (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: currentPage == index ? Colors.black : Colors.grey[300],
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),

      // [
      // Container(
      //   width: 8,
      //   height: 8,
      //   margin: const EdgeInsets.symmetric(horizontal: 5.0),
      //   decoration: BoxDecoration(
      //     color: currentPage == 0 ? Colors.black : Colors.grey[300],
      //     borderRadius: BorderRadius.circular(5.0),
      //   ),
      // ),
      // Container(
      //   width: 8,
      //   height: 8,
      //   margin: const EdgeInsets.symmetric(horizontal: 5.0),
      //   decoration: BoxDecoration(
      //     color: currentPage == 1 ? Colors.black : Colors.grey[300],
      //     borderRadius: BorderRadius.circular(5.0),
      //   ),
      // ),
      // Container(
      //   width: 8,
      //   height: 8,
      //   margin: const EdgeInsets.symmetric(horizontal: 5.0),
      //   decoration: BoxDecoration(
      //     color: currentPage == 2 ? Colors.black : Colors.grey[300],
      //     borderRadius: BorderRadius.circular(5.0),
      //   ),
      // ),
      // ],
    );
  }
}

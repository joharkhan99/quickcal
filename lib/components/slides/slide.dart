import 'package:flutter/material.dart';

class Slide extends StatelessWidget {
  final slide;
  const Slide({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            slide['imageUrl'],
            height: 220.0,
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
          const SizedBox(height: 30.0),
          Text(
            slide['title'],
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10.0),
          Text(
            slide['description'],
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromARGB(164, 46, 43, 45),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

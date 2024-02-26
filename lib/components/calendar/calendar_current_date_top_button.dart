import 'package:flutter/material.dart';

class CurrentDateTopButton extends StatelessWidget {
  final Function updateCalendarToToday;
  const CurrentDateTopButton({super.key, required this.updateCalendarToToday});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          width: 22,
          height: 22,
          top: 13,
          right: 13,
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(color: Color.fromARGB(0, 233, 91, 91)),
            child: Text(
              '${DateTime.now().day}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today_outlined),
          onPressed: () => updateCalendarToToday(DateTime.now()),
          tooltip: 'Today',
        ),
      ],
    );
  }
}

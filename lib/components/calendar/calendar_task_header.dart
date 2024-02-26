import 'package:flutter/material.dart';
import 'package:quickcal/models/calendar.dart';

class CalendarTaskHeader extends StatelessWidget {
  final Calendar calendar;
  final DateTime selectedDate;
  const CalendarTaskHeader({
    super.key,
    required this.calendar,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3, left: 5),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Schedule for ${calendar.getCurrentMonthName()} ${selectedDate.day}, ${selectedDate.year}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "3 Events",
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(164, 46, 43, 45),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

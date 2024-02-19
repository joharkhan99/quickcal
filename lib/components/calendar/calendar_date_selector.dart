import 'package:flutter/material.dart';
import 'package:quickcal/models/calendar.dart';

class CalendarDateSelector extends StatelessWidget {
  final Calendar calendar;
  final Function selectDate;
  const CalendarDateSelector({
    super.key,
    required this.calendar,
    required this.selectDate,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.all(0),
          foregroundColor: Colors.black.withAlpha(50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
      onPressed: () => selectDate(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            calendar.getCurrentMonthName(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          Text(
            calendar.getCurrentYear().toString(),
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(164, 46, 43, 45),
            ),
          ),
        ],
      ),
    );
  }
}

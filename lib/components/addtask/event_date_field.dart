import 'package:flutter/material.dart';
import 'package:quickcal/models/task.dart';

class DateField extends StatefulWidget {
  final Task task;
  const DateField({super.key, required this.task});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        widget.task.setDate(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.465,
          child: ElevatedButton(
            onPressed: () => _selectDate(context),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              alignment: Alignment.centerLeft,
              side: const BorderSide(color: Color.fromARGB(50, 46, 43, 45), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date: ${widget.task.date.day}/${widget.task.date.month}/${widget.task.date.year}",
                  style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const Icon(
                  Icons.calendar_month_outlined,
                  color: Color.fromARGB(150, 46, 43, 45),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

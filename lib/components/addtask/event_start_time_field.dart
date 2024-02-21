import 'package:flutter/material.dart';
import 'package:quickcal/models/task.dart';

class StartTimeField extends StatefulWidget {
  final Task task;
  const StartTimeField({super.key, required this.task});

  @override
  State<StartTimeField> createState() => _StartTimeFieldState();
}

class _StartTimeFieldState extends State<StartTimeField> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: selectedTime);

    if (picked != null) {
      setState(() {
        widget.task.setStartTime(picked);
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
            onPressed: () => _selectTime(context),
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
                  "${widget.task.startTime.hourOfPeriod}:${widget.task.startTime.minute} ${widget.task.startTime.period.name.toUpperCase()}",
                  style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const Icon(
                  Icons.watch_later_outlined,
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

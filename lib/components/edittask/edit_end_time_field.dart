import 'package:flutter/material.dart';
import 'package:quickcal/models/task.dart';

class EditEndTimeField extends StatefulWidget {
  final Task task;
  const EditEndTimeField({super.key, required this.task});

  @override
  State<EditEndTimeField> createState() => _EditEndTimeFieldState();
}

class _EditEndTimeFieldState extends State<EditEndTimeField> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: selectedTime);

    if (picked != null) {
      setState(() {
        widget.task.setEndTime(picked);
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
              shadowColor: Colors.white,
              foregroundColor: Colors.white,
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
                  "End: ${widget.task.endTime.hourOfPeriod}:${widget.task.endTime.minute} ${widget.task.endTime.period.name.toUpperCase()}",
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

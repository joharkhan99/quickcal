import 'package:flutter/material.dart';
import 'package:quickcal/models/task.dart';

class EditDateField extends StatefulWidget {
  final Task task;
  final DateTime userSelectedDate;
  const EditDateField({super.key, required this.task, required this.userSelectedDate});

  @override
  State<EditDateField> createState() => _EditDateFieldState();
}

class _EditDateFieldState extends State<EditDateField> {
  // assign to the user selected date
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    selectedDate = widget.userSelectedDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        widget.task.setDate(picked);
      });
      // print('Picked date: $selectedDate');
      // widget.task.printTask();
      // print('Picked date: $selectedDate');
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
                  "Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
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

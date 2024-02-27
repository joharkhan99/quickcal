import 'package:flutter/material.dart';
import 'package:quickcal/models/task.dart';

class EditNotifyField extends StatelessWidget {
  final Task task;
  const EditNotifyField({super.key, required this.task});

  void handleSwitchChange(String value) {
    task.setNotifyTime(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.465,
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(50, 46, 43, 45), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(50, 46, 43, 45), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            value: task.notifyTime,
            icon: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  color: Color.fromARGB(150, 46, 43, 45),
                  size: 20,
                ),
              ],
            ),
            elevation: 16,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            dropdownColor: Colors.white,
            onChanged: (String? value) => handleSwitchChange(value!),
            items: task.times.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

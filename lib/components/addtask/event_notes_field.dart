import 'package:flutter/material.dart';

class EventNotesField extends StatelessWidget {
  const EventNotesField({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      maxLines: 3,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        labelText: 'Type any notes here...',
        hintText: 'go to the gym, buy groceries, etc.',
        alignLabelWithHint: true,
        floatingLabelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(50, 46, 43, 45), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }
}

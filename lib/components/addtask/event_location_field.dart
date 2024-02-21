import 'package:flutter/material.dart';

class EventLocationField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  const EventLocationField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Location',
        hintText: 'Enter event location',
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
        suffixIcon: Icon(
          Icons.location_on_outlined,
          color: Color.fromARGB(150, 46, 43, 45),
          size: 20,
        ),
      ),
    );
  }
}

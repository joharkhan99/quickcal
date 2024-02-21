import 'package:flutter/material.dart';

class Task {
  late String name;
  late DateTime date;
  late bool allDay;
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  late String notifyTime;
  late Color color;
  late String location;
  late String notes;

  final List<String> times = ['None', 'On time', '5 mins before', '10 mins before', '15 mins before', '30 mins before', '1 hour before'];
  final List<Color> colors = [
    Colors.blueAccent,
    Colors.red,
    Colors.purple.shade300,
    Colors.blue.shade200,
    Colors.green.shade600,
    Colors.pink.shade200,
    Colors.teal.shade400,
    Colors.amber.shade600,
    Colors.brown.shade300,
    Colors.indigo.shade400,
    Colors.lightGreen,
    Colors.deepPurple,
    Colors.cyan,
    Colors.lime,
  ];

  Task() {
    name = '';
    date = DateTime.now();
    allDay = true;
    startTime = TimeOfDay.now();
    endTime = TimeOfDay.now();
    notifyTime = times[0];
    color = Colors.blue;
    location = '';
    notes = '';
  }

  void setName(String name) {
    this.name = name;
  }

  void setDate(DateTime date) {
    this.date = date;
  }

  void setAllDay(bool allDay) {
    this.allDay = allDay;
  }

  void setStartTime(TimeOfDay startTime) {
    this.startTime = startTime;
  }

  void setEndTime(TimeOfDay endTime) {
    this.endTime = endTime;
  }

  void setNotifyTime(String notifyTime) {
    this.notifyTime = notifyTime;
  }

  void setColor(Color color) {
    this.color = color;
  }

  void setLocation(String location) {
    this.location = location;
  }

  void setNotes(String notes) {
    this.notes = notes;
  }

  String getName() {
    return name;
  }

  DateTime getDate() {
    return date;
  }

  bool getAllDay() {
    return allDay;
  }

  TimeOfDay getStartTime() {
    return startTime;
  }

  TimeOfDay getEndTime() {
    return endTime;
  }

  String getNotifyTime() {
    return notifyTime;
  }

  Color getColor() {
    return color;
  }

  String getLocation() {
    return location;
  }

  String getNotes() {
    return notes;
  }

  void printTask() {
    print('Name: $name');
    print('Date: $date');
    print('All Day: $allDay');
    print('Start Time: $startTime');
    print('End Time: $endTime');
    print('isAllDay: $notifyTime');
    print('Color: $color');
    print('Location: $location');
    print('Notes: $notes');
  }
}

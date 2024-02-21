import 'package:flutter/material.dart';

class Task {
  late String name;
  late DateTime date;
  late bool allDay;
  late DateTime startTime;
  late DateTime endTime;
  late String isAllDay;
  late Color color;
  late String location;
  late String notes;

  Task() {
    name = '';
    date = DateTime.now();
    allDay = true;
    startTime = DateTime.now();
    endTime = DateTime.now();
    isAllDay = '';
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

  void setStartTime(DateTime startTime) {
    this.startTime = startTime;
  }

  void setEndTime(DateTime endTime) {
    this.endTime = endTime;
  }

  void setisAllDay(String isAllDay) {
    this.isAllDay = isAllDay;
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

  DateTime getStartTime() {
    return startTime;
  }

  DateTime getEndTime() {
    return endTime;
  }

  String getisAllDay() {
    return isAllDay;
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
    print('isAllDay: $isAllDay');
    print('Color: $color');
    print('Location: $location');
    print('Notes: $notes');
  }
}

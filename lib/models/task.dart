import 'package:flutter/material.dart';

class Task {
  late String name;
  late DateTime date;
  late bool allDay;
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  late String notifyTime;
  late int colorIndex;
  late String location;
  late String notes;
  late String taskId;

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
    // color = Colors.blue;
    colorIndex = 0;
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

  void setColorIndex(int colorIndex) {
    this.colorIndex = colorIndex;
  }

  void setLocation(String location) {
    this.location = location;
  }

  void setNotes(String notes) {
    this.notes = notes;
  }

  void setTaskId(String taskId) {
    this.taskId = taskId;
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

  int getColorIndex() {
    return colorIndex;
  }

  Color getColor() {
    return colors[colorIndex];
  }

  String getLocation() {
    return location;
  }

  String getNotes() {
    return notes;
  }

  String getTaskId() {
    return taskId;
  }

  String generateTaskId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  void printTask() {
    print(
        'Task ID: $taskId | Name: $name | Date: $date | All Day: $allDay | Start Time: $startTime | End Time: $endTime | Notify Time: $notifyTime | Color: $colorIndex | Location: $location | Notes: $notes');
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date.toIso8601String(),
      'allDay': allDay,
      'startTime': startTime.toString(),
      'endTime': endTime.toString(),
      'notifyTime': notifyTime,
      'colorIndex': colorIndex.toString(),
      'location': location,
      'notes': notes,
      'taskId': taskId,
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    date = DateTime.parse(json['date']);

    List<String> startTimeParts = json['startTime'].substring(10, json['startTime'].length - 1).split(':');
    int startTimeHour = int.parse(startTimeParts[0]);
    int startTimeMinute = int.parse(startTimeParts[1]);
    TimeOfDay startTime = TimeOfDay(hour: startTimeHour, minute: startTimeMinute);

    List<String> endTimeParts = json['endTime'].substring(10, json['endTime'].length - 1).split(':');
    int endTimeHour = int.parse(endTimeParts[0]);
    int endTimeMinute = int.parse(endTimeParts[1]);
    TimeOfDay endTime = TimeOfDay(hour: endTimeHour, minute: endTimeMinute);

    _fromJson({
      'name': json['name'],
      'date': date,
      'allDay': json['allDay'],
      'startTime': startTime,
      'endTime': endTime,
      'notifyTime': json['notifyTime'],
      'colorIndex': json['colorIndex'],
      'location': json['location'],
      'notes': json['notes'],
      'taskId': json['taskId'],
    });
  }

  void _fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    allDay = json['allDay'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    notifyTime = json['notifyTime'];
    colorIndex = int.parse(json['colorIndex']);
    location = json['location'];
    notes = json['notes'];
    taskId = json['taskId'];
  }
}

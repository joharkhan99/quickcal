import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quickcal/components/addtask/event_end_time_field.dart';
import 'package:quickcal/components/edittask/Edit_all_day_field.dart';
import 'package:quickcal/components/edittask/Edit_bottom_buttons.dart';
import 'package:quickcal/components/edittask/edit_color_field.dart';
import 'package:quickcal/components/edittask/edit_location_field.dart';
import 'package:quickcal/components/edittask/edit_name_field.dart';
import 'package:quickcal/components/edittask/edit_notes_field.dart';
import 'package:quickcal/components/edittask/edit_notify_field.dart';
import 'package:quickcal/components/edittask/edit_start_time_field.dart';
import 'package:quickcal/components/misc/alert_message.dart';
import 'package:quickcal/data/database.dart';
import 'package:quickcal/models/task.dart';
import 'package:quickcal/notification_service.dart';

class EditTaskPage extends StatefulWidget {
  // DateTime selectedDate;
  Task task;
  Function handleDateCardClick;
  EditTaskPage({super.key, required this.task, required this.handleDateCardClick});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late bool light;
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  Database database = Database();
  late DateTime oldDate;
  late String taskOldId;

  @override
  void initState() {
    super.initState();

    light = widget.task.allDay;
    _nameController.text = widget.task.name;
    _locationController.text = widget.task.location;
    _notesController.text = widget.task.notes;
    oldDate = widget.task.date;
    taskOldId = widget.task.taskId;
  }

  void changeReminderSwitch(bool value) {
    setState(() {
      light = value;
      widget.task.setAllDay(value);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.task.date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        widget.task.setDate(picked);
      });
    }
  }

  String getTaskNotes(Task task) {
    if (task.notes == '') {
      return 'Not specified';
    } else if (task.notes.length > 50) {
      return '${task.notes.substring(0, 50)}...';
    } else {
      return task.notes;
    }
  }

  int getTaskNotifyTime(String notify) {
    int notifyTime = 0;
    switch (notify) {
      case 'None':
        notifyTime = 0;
        break;
      case 'On time':
        notifyTime = 0;
        break;
      case '5 mins before':
        notifyTime = 5;
        break;
      case '10 mins before':
        notifyTime = 10;
        break;
      case '15 mins before':
        notifyTime = 15;
        break;
      case '30 mins before':
        notifyTime = 30;
        break;
      case '1 hour before':
        notifyTime = 60;
        break;
      case '2 hours before':
        notifyTime = 120;
        break;
      default:
        notifyTime = 0;
    }
    return notifyTime;
  }

  int setNotification(Task task) {
    if (task.notifyTime != 'None') {
      int notifyTime = getTaskNotifyTime(task.notifyTime);
      int notificationTimeInSeconds = notifyTime * 60;

      if (task.allDay) {
        notificationTimeInSeconds = 0;
      } else {
        notificationTimeInSeconds = task.startTime.hour * 3600 + task.startTime.minute * 60 - notificationTimeInSeconds;
      }

      // 3600 seconds in an hour, 60 seconds in a minute
      DateTime notificationTime = DateTime(task.date.year, task.date.month, task.date.day, notificationTimeInSeconds ~/ 3600, (notificationTimeInSeconds % 3600) ~/ 60);

      int notificationId = Random().nextInt(10000);
      String notificationBody = '${task.name} is Scheduled at ${task.startTime.format(context)}';
      String notificationBigText =
          'Date: ${task.date.day}/${task.date.month}/${task.date.year}<br>Time: ${task.startTime.format(context)}-${task.endTime.format(context)}<br>Location: ${task.location == '' ? 'Not Specified' : task.location}<br>Notes: ${getTaskNotes(task)}';

      LocalNotificationService().scheduleNotification(
        notificationId,
        notificationBody,
        notificationBigText,
        task.name,
        notificationTime,
      );

      return notificationId;
    }

    return -1;
  }

  void onSave() {
    widget.task.setName(_nameController.text);
    widget.task.setLocation(_locationController.text);
    widget.task.setNotes(_notesController.text);

    if (_nameController.text.isEmpty) {
      AlertMessage(context, 'Name field is empty', 'Please enter a name for the event');
      return;
    }

    widget.task.setTaskId(widget.task.generateTaskId());
    widget.task.setDate(widget.task.date);

    // delete old notification
    LocalNotificationService().cancelNotification(widget.task.notificationId);

    // set new notification
    int notificationId = setNotification(widget.task);
    widget.task.setNotificationId(notificationId);

    database.updateData(widget.task, oldDate, taskOldId);

    _nameController.clear();
    _locationController.clear();
    _notesController.clear();
    widget.handleDateCardClick(widget.task.date);

    widget.task = Task();

    const snackBar = SnackBar(content: Text("Event updated Successfully!"), duration: Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
  }

  void onCancel() {
    _nameController.clear();
    _locationController.clear();
    _notesController.clear();
    widget.task = Task();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'Edit Event',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      EditNameField(controller: _nameController),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // DateField(task: task, userSelectedDate: widget.selectedDate),
                          Row(
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
                          ),
                          // DateField(task: task, userSelectedDate: widget.selectedDate),

                          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          EditAllDayField(changeReminderSwitch: changeReminderSwitch, light: light),
                        ],
                      ),
                      widget.task.allDay
                          ? Container()
                          : Column(
                              children: [
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EditStartTimeField(task: widget.task),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                                    EndTimeField(task: widget.task),
                                  ],
                                ),
                              ],
                            ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          EditNotifyField(task: widget.task),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          EditColorField(task: widget.task),
                        ],
                      ),
                      const SizedBox(height: 15),
                      EditLocationField(controller: _locationController),
                      const SizedBox(height: 15),
                      EditNotesField(controller: _notesController),
                    ],
                  ),
                ),
              ),
            ),
            EditBottomButtons(onSave: onSave, onCancel: onCancel),
          ],
        ),
      ),
    );
  }
}

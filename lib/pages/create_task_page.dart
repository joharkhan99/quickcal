import 'package:flutter/material.dart';
import 'package:quickcal/components/addtask/event_all_day_field.dart';
import 'package:quickcal/components/addtask/event_bottom_buttons.dart';
import 'package:quickcal/components/addtask/event_date_field.dart';
import 'package:quickcal/components/addtask/event_end_time_field.dart';
import 'package:quickcal/components/addtask/event_color_field.dart';
import 'package:quickcal/components/addtask/event_location_field.dart';
import 'package:quickcal/components/addtask/event_name_field.dart';
import 'package:quickcal/components/addtask/event_notes_field.dart';
import 'package:quickcal/components/addtask/event_notify_field.dart';
import 'package:quickcal/components/addtask/event_start_time_field.dart';
import 'package:quickcal/components/alert_message.dart';
import 'package:quickcal/data/database.dart';
import 'package:quickcal/models/task.dart';

class CreateTaskPage extends StatefulWidget {
  DateTime selectedDate;
  CreateTaskPage({super.key, required this.selectedDate});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  late Task task;
  late bool light;
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  Database database = Database();

  @override
  void initState() {
    super.initState();

    task = Task();
    light = task.allDay;
  }

  void changeReminderSwitch(bool value) {
    setState(() {
      light = value;
      task.setAllDay(value);
    });
  }

  void onSave() {
    task.setName(_nameController.text);
    task.setLocation(_locationController.text);
    task.setNotes(_notesController.text);

    if (_nameController.text.isEmpty) {
      AlertMessage(context, 'Name field is empty', 'Please enter a name for the event');
      return;
    }

    if (task.date.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      AlertMessage(context, 'Invalid date', 'Please select a valid date');
      return;
    }

    task.setTaskId(task.generateTaskId());
    database.saveData(widget.selectedDate, task);

    // clear all the fields
    _nameController.clear();
    _locationController.clear();
    _notesController.clear();
    task = Task();

    Navigator.pop(context);
  }

  void onCancel() {
    // clear all the fields
    _nameController.clear();
    _locationController.clear();
    _notesController.clear();
    // clear the task object
    task = Task();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Add new Event',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    EventNameField(controller: _nameController),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DateField(task: task, userSelectedDate: widget.selectedDate),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                        EventAllDayField(changeReminderSwitch: changeReminderSwitch, light: light),
                      ],
                    ),
                    task.allDay
                        ? Container()
                        : Column(
                            children: [
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  StartTimeField(task: task),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                                  EndTimeField(task: task),
                                ],
                              ),
                            ],
                          ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        EventNotifyField(task: task),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                        EventColorField(task: task),
                      ],
                    ),
                    const SizedBox(height: 15),
                    EventLocationField(controller: _locationController),
                    const SizedBox(height: 15),
                    EventNotesField(controller: _notesController),
                  ],
                ),
              ),
            ),
          ),
          BottomButtons(onSave: onSave, onCancel: onCancel),
        ],
      ),
    );
  }
}

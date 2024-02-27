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
import 'package:quickcal/components/misc/alert_message.dart';
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        widget.selectedDate = picked;
        task.setDate(picked);
      });
    }
  }

  void onSave() {
    task.setName(_nameController.text);
    task.setLocation(_locationController.text);
    task.setNotes(_notesController.text);

    if (_nameController.text.isEmpty) {
      AlertMessage(context, 'Name field is empty', 'Please enter a name for the event');
      return;
    }

    task.setTaskId(task.generateTaskId());
    task.setDate(widget.selectedDate);
    database.saveData(task);

    _nameController.clear();
    _locationController.clear();
    _notesController.clear();
    task = Task();

    Navigator.pop(context);
  }

  void onCancel() {
    _nameController.clear();
    _locationController.clear();
    _notesController.clear();
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
                                      "Date: ${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}",
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

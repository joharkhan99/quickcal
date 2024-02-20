import 'package:flutter/material.dart';
import 'package:quickcal/components/addtask/event_bottom_buttons.dart';
import 'package:quickcal/components/addtask/event_date_field.dart';
import 'package:quickcal/components/addtask/event_end_time_field.dart';
import 'package:quickcal/components/addtask/event_color_field.dart';
import 'package:quickcal/components/addtask/event_location_field.dart';
import 'package:quickcal/components/addtask/event_name_field.dart';
import 'package:quickcal/components/addtask/event_notes_field.dart';
import 'package:quickcal/components/addtask/event_notify_field.dart';
import 'package:quickcal/components/addtask/event_reminder_field.dart';
import 'package:quickcal/components/addtask/event_start_time_field.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  bool light = true;

  void changeReminderSwitch(bool value) {
    setState(() {
      light = value;
    });
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
        // backgroundColor: Colors.grey.shade200,
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
                    const EventNameField(),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const DateField(),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                        EventReminderField(changeReminderSwitch: changeReminderSwitch, light: light),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const StartTimeField(),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                        const EndTimeField(),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const EventNotifyField(),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                        const EventColorField(),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const EventLocationField(),
                    const SizedBox(height: 15),
                    const EventNotesField(),
                  ],
                ),
              ),
            ),
          ),
          const BottomButtons(),
        ],
      ),
    );
  }
}

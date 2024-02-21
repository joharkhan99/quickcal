import 'package:flutter/material.dart';
import 'package:quickcal/components/calendar/calendar_date_selector.dart';
import 'package:quickcal/components/calendar/calendar_grid.dart';
import 'package:quickcal/components/calendar/calendar_task_header.dart';
import 'package:quickcal/components/calendar/calendar_tasks_list.dart';
import 'package:quickcal/components/calendar/calendar_current_date_top_button.dart';
import 'package:quickcal/components/calendar/calendar_popup_menu.dart';
import 'package:quickcal/models/calendar.dart';
import 'package:quickcal/pages/create_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Calendar calendar = Calendar();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (date != null && date != DateTime.now()) {
      setState(() {
        calendar.setCurrentMonth(date);
        selectedDate = date;
      });
      // print('Selected Date: $date');
    }
  }

  void updateCalendarToToday() {
    setState(() {
      calendar.setCurrentMonth(DateTime.now());
      selectedDate = DateTime.now();
    });
  }

  void handleDateCardClick(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateTaskPage(
                      selectedDate: selectedDate,
                    )),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [CalendarDateSelector(calendar: calendar, selectDate: _selectDate)],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        actions: [
          CurrentDateTopButton(updateCalendarToToday: updateCalendarToToday),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            tooltip: 'Search',
          ),
          const PopUpMenu(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            CalendarGrid(calendar: calendar, selectedDate: selectedDate, handleDateCardClick: handleDateCardClick),
            CalendarTaskHeader(calendar: calendar, selectedDate: selectedDate),
            const CalendarTasksList()
          ],
        ),
      ),
    );
  }
}

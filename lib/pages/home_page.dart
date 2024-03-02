import 'package:flutter/material.dart';
import 'package:quickcal/components/calendar/calendar_date_selector.dart';
import 'package:quickcal/components/calendar/calendar_grid.dart';
import 'package:quickcal/components/calendar/calendar_task_header.dart';
import 'package:quickcal/components/calendar/calendar_tasks_list.dart';
import 'package:quickcal/components/calendar/calendar_current_date_top_button.dart';
// import 'package:quickcal/components/calendar/calendar_popup_menu.dart';
import 'package:quickcal/components/misc/search_bottom_sheet.dart';
import 'package:quickcal/data/database.dart';
import 'package:quickcal/models/calendar.dart';
import 'package:quickcal/models/task.dart';
import 'package:quickcal/pages/create_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Calendar calendar = Calendar();
  late DateTime selectedDate;
  Database database = Database();
  late List<Task> tasksForDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    tasksForDate = database.getTasksForDate(selectedDate);
    handleDateCardClick(selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (date != null) {
      setState(() {
        calendar.setCurrentMonth(date);
        selectedDate = date;
        tasksForDate = database.getTasksForDate(date);
      });
    }
  }

  void updateCalendarToToday(DateTime date) {
    setState(() {
      calendar.setCurrentMonth(date);
      selectedDate = date;
      tasksForDate = database.getTasksForDate(date);
    });
  }

  void handleDateCardClick(DateTime date) {
    setState(() {
      selectedDate = date;
      tasksForDate = database.getTasksForDate(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTaskPage(selectedDate: selectedDate, handleDateCardClick: handleDateCardClick),
            ),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [CalendarDateSelector(calendar: calendar, selectDate: _selectDate)],
        ),
        backgroundColor: Colors.grey[300],
        elevation: 0,
        scrolledUnderElevation: 0.0,
        actions: [
          CurrentDateTopButton(updateCalendarToToday: updateCalendarToToday),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => searchButtonClick(context),
              tooltip: 'Search',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.dark_mode_outlined),
            onPressed: () => (),
            tooltip: 'Theme',
          ),
          // const PopUpMenu(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                CalendarGrid(
                  calendar: calendar,
                  selectedDate: selectedDate,
                  handleDateCardClick: handleDateCardClick,
                  database: database,
                ),
                CalendarTaskHeader(calendar: calendar, selectedDate: selectedDate),
                tasksForDate.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'No events. Tap + to add a new event.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : CalendarTasksList(
                        tasksForDate: tasksForDate,
                        handleDateCardClick: handleDateCardClick,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  searchButtonClick(BuildContext context) {
    return showBottomSheet(
      context: context,
      builder: (context) => SearchBottomSheet(handleDateCardClick: handleDateCardClick),
    );
  }
}

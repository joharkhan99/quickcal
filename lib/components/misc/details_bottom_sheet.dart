import 'package:flutter/material.dart';
import 'package:quickcal/data/database.dart';
import 'package:quickcal/models/task.dart';
import 'package:quickcal/notification_service.dart';
import 'package:quickcal/pages/edit_task_page.dart';

class DetailsBottomSheet extends StatelessWidget {
  Task task;
  Function handleDateCardClick;
  DetailsBottomSheet({super.key, required this.task, required this.handleDateCardClick});
  Database database = Database();

  String getTaskTime(Task task, BuildContext context) {
    if (task.allDay) {
      return 'All day';
    } else {
      return '${task.startTime.format(context)} - ${task.endTime.format(context)}';
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

  void deleteEvent(BuildContext context) {
    DateTime oldDate = task.date;
    LocalNotificationService().cancelNotification(task.notificationId);
    database.deleteTask(task);
    handleDateCardClick(oldDate);
    const snackBar = SnackBar(content: Text("Event removed Successfully!"), duration: Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(94, 0, 0, 0),
            spreadRadius: 40,
            blurRadius: 100,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black.withOpacity(0.5),
                    size: 20,
                  ),
                  Text(
                    task.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: task.getColor(),
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        fill: 1,
                        size: 15,
                        color: task.getColor(),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${task.date.day}/${task.date.month}/${task.date.year}',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Icon(
                        Icons.access_time,
                        fill: 1,
                        size: 15,
                        color: task.getColor(),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        getTaskTime(task, context),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_none,
                        size: 15,
                        color: task.getColor().withOpacity(0.9),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        task.notifyTime,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Icon(
                        Icons.location_on_outlined,
                        fill: 1,
                        size: 15,
                        color: task.getColor(),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        task.location == '' ? 'Not specified' : task.location,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.notes_outlined,
                        fill: 1,
                        size: 15,
                        color: task.getColor(),
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          task.notes == '' ? 'Not specified' : task.notes,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  // 50% of screen width
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: ElevatedButton(
                    onPressed: () => deleteEvent(context),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        backgroundColor: Colors.grey.shade300,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0),
                    child: const Text(
                      'Remove',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTaskPage(task: task, handleDateCardClick: handleDateCardClick),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      backgroundColor: task.getColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quickcal/models/task.dart';

class CalendarTasksList extends StatelessWidget {
  List<Task> tasksForDate;
  CalendarTasksList({super.key, required this.tasksForDate});

  String getTaskTime(Task task, BuildContext context) {
    if (task.allDay) {
      return 'All day';
    } else {
      return '${task.startTime.format(context)} - ${task.endTime.format(context)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
        itemCount: tasksForDate.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: tasksForDate[index].getColor().withOpacity(0.7),
                  width: 8,
                ),
              ),
              color: Colors.white,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: tasksForDate[index].getColor().withOpacity(0.12),
                foregroundColor: Colors.white,
                elevation: 0,
                shadowColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tasksForDate[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: tasksForDate[index].getColor(),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              fill: 1,
                              size: 15,
                              color: tasksForDate[index].getColor(),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              getTaskTime(tasksForDate[index], context),
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Icon(
                              Icons.notifications_none,
                              size: 15,
                              color: tasksForDate[index].getColor().withOpacity(0.9),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              tasksForDate[index].notifyTime,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              fill: 1,
                              size: 15,
                              color: tasksForDate[index].getColor(),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              tasksForDate[index].location == '' ? 'Not specified' : tasksForDate[index].location,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.notes_outlined,
                              fill: 1,
                              size: 15,
                              color: tasksForDate[index].getColor(),
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                tasksForDate[index].notes == '' ? 'Not specified' : '${tasksForDate[index].notes.substring(0, 50)}...',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

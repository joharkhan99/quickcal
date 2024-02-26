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
                  color: tasksForDate[index].getColor(),
                  width: 8,
                ),
              ),
              color: Colors.white,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: tasksForDate[index].getColor().withOpacity(0.15),
                foregroundColor: Colors.black.withAlpha(50),
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
                  // Container(
                  //   width: 12,
                  //   height: 12,
                  //   decoration: BoxDecoration(
                  //     color: tasksForDate[index].getColor(),
                  //     shape: BoxShape.circle,
                  //   ),
                  // ),
                  // const SizedBox(width: 12),
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
                        Row(
                          children: [
                            Text(
                              getTaskTime(tasksForDate[index], context),
                              style: const TextStyle(
                                color: Color.fromARGB(164, 46, 43, 45),
                                fontSize: 12,
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

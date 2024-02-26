import 'package:flutter/material.dart';
import 'package:quickcal/models/task.dart';

class CalendarTasksList extends StatelessWidget {
  List<Task> tasksForDate;
  CalendarTasksList({super.key, required this.tasksForDate});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: tasksForDate.length,
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black.withAlpha(50),
              elevation: 0,
              shadowColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: tasksForDate[index].getColor(),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tasksForDate[index].name,
                        style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      Text('${tasksForDate[index].startTime.hour.toString()} - ${tasksForDate[index].endTime.hour.toString()}',
                          style: const TextStyle(color: Color.fromARGB(164, 46, 43, 45), fontSize: 12)),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

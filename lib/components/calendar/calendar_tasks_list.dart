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

  String getTaskNotes(Task task) {
    if (task.notes == '') {
      return 'Not specified';
    } else if (task.notes.length > 50) {
      return '${task.notes.substring(0, 50)}...';
    } else {
      return task.notes;
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
              onPressed: () => showBottomSheet(
                context: context,
                builder: (context) => Container(
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
                                tasksForDate[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: tasksForDate[index].getColor(),
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 10),
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
                                      fontSize: 15,
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
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
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
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
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
                                      tasksForDate[index].notes,
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
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
                                onPressed: () => (),
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
                                onPressed: () => (),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 13),
                                  backgroundColor: tasksForDate[index].getColor(),
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
                ),
              ),
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
                                getTaskNotes(tasksForDate[index]),
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

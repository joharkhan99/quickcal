import 'package:flutter/material.dart';
import 'package:quickcal/components/misc/details_bottom_sheet.dart';
import 'package:quickcal/data/database.dart';
import 'package:quickcal/models/task.dart';

class SearchBottomSheet extends StatefulWidget {
  Function handleDateCardClick;
  SearchBottomSheet({super.key, required this.handleDateCardClick});

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  Database database = Database();

  final _inputController = TextEditingController();

  late Future<List<Task>> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = database.searchTasksByName("");
  }

  void searchTasks(String value) {
    setState(() {
      _searchResults = database.searchTasksByName(value);
      // print(tasks);
    });
  }

  taskDetails(BuildContext context, Task task) {
    return showBottomSheet(
      context: context,
      builder: (context) => DetailsBottomSheet(task: task, handleDateCardClick: widget.handleDateCardClick),
    );
  }

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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 40),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(94, 0, 0, 0),
            spreadRadius: 10,
            blurRadius: 100,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: TextFormField(
              controller: _inputController,
              onChanged: (value) => searchTasks(value),
              decoration: const InputDecoration(
                labelText: 'Search your events...',
                hintText: 'go to the gym, buy groceries, etc.',
                fillColor: Color.fromARGB(26, 158, 158, 158),
                filled: true,
                floatingLabelStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(50, 46, 43, 45), width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                suffixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(150, 46, 43, 45),
                  size: 24,
                ),
              ),
            ),
          ),
          const Text('Search results', style: TextStyle(color: Colors.black, fontSize: 12)),
          const SizedBox(height: 5),
          FutureBuilder<List<Task>>(
            future: _searchResults,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  strokeWidth: 1,
                  color: Colors.black12,
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Task> tasks = snapshot.data ?? [];

                return Expanded(
                  flex: 1,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: tasks[index].getColor().withOpacity(0.7),
                              width: 8,
                            ),
                          ),
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
                        ),
                        child: ElevatedButton(
                          onPressed: () => taskDetails(context, tasks[index]),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tasks[index].getColor().withOpacity(0.12),
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
                                      tasks[index].name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: tasks[index].getColor(),
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          fill: 1,
                                          size: 15,
                                          color: tasks[index].getColor(),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '${tasks[index].date.day}/${tasks[index].date.month}/${tasks[index].date.year}',
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.5),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Icon(
                                          Icons.access_time,
                                          fill: 1,
                                          size: 15,
                                          color: tasks[index].getColor(),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          getTaskTime(tasks[index], context),
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.5),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.notifications_none,
                                          size: 15,
                                          color: tasks[index].getColor().withOpacity(0.9),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          tasks[index].notifyTime,
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.5),
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
            },
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quickcal/models/task.dart';

class Database {
  // reference box
  final tasksbox = Hive.box('tasksbox');

  void loadData(DateTime date) {
    var tasks = tasksbox.get(date.toString()) ?? [];
    for (var task in tasks) {
      var encodedTask = jsonEncode(task);
      Map<String, dynamic> decodedTask = json.decode(encodedTask);
      Task t = Task.fromJson(decodedTask);
      t.printTask();
    }
  }

  void saveData(Task newtask) {
    var tasksForDate = tasksbox.get(newtask.date.toString()) ?? [];
    tasksForDate.add(newtask.toJson());
    tasksbox.put(newtask.date.toString(), tasksForDate);
    print('Task saved');
    print(tasksForDate);
  }

  List<Task> getTasksForDate(DateTime date) {
    List<Task> tasks = [];
    var savedTasks = tasksbox.get(date.toString()) ?? [];
    for (var task in savedTasks) {
      var encodedTask = jsonEncode(task);
      Map<String, dynamic> decodedTask = json.decode(encodedTask);
      Task t = Task.fromJson(decodedTask);
      tasks.add(t);
    }
    return tasks;
  }

  void deleteTask(Task task) {
    task.printTask();
    var tasksForDate = tasksbox.get(task.date.toString()) ?? [];
    print(tasksForDate);
    tasksForDate.removeWhere((element) => element['taskId'] == task.taskId);
    tasksbox.put(task.date.toString(), tasksForDate);
  }
}

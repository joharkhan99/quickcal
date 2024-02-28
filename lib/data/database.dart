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
  }

  void updateData(Task updatedTask, DateTime oldDate, String taskOldId) {
    // delete task from old date
    deleteByTaskId(taskOldId, oldDate);
    // add task to new date
    saveData(updatedTask);
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
    var tasksForDate = tasksbox.get(task.date.toString()) ?? [];
    tasksForDate.removeWhere((element) => element['taskId'] == task.taskId);
    tasksbox.put(task.date.toString(), tasksForDate);
  }

  void deleteByTaskId(String taskId, DateTime date) {
    var tasksForDate = tasksbox.get(date.toString()) ?? [];
    tasksForDate.removeWhere((element) => element['taskId'] == taskId);
    tasksbox.put(date.toString(), tasksForDate);
  }

  Future<List<Task>> searchTasksByName(String searchValue) async {
    final List<Map<dynamic, dynamic>> matchingTasks = [];

    for (var key in tasksbox.keys) {
      final List<dynamic> tasks = tasksbox.get(key);

      for (var task in tasks) {
        if (task['name'] != null &&
            (task['name'].toLowerCase().contains(searchValue.toLowerCase()) ||
                task['notes'].toLowerCase().contains(searchValue.toLowerCase()) ||
                task['location'].toLowerCase().contains(searchValue.toLowerCase()))) {
          matchingTasks.add(task);
        }
      }
    }

    List<Task> taskList = [];

    for (Map<dynamic, dynamic> map in matchingTasks) {
      var encodedTask = jsonEncode(map);
      Map<String, dynamic> decodedTask = json.decode(encodedTask);
      Task t = Task.fromJson(decodedTask);
      taskList.add(t);
    }

    return taskList;
  }
}

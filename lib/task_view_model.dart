/*
Author: Plamedi Diakubama
Date: 6/17/2023
Project: Task Planner app
Task Tracker is a productivity app that helps users organize and manage their daily tasks.
It provides a user-friendly interface with intuitive features to enhance productivity and efficiency.
Description: This is the view model
 */

import 'package:flutter/material.dart';
import 'task.dart';
import 'task_dao.dart';
import 'task_database.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskDatabase _database;
  late TaskDao _taskDao;
  late List<Task> _tasks;
  bool isLoading = true;

  TaskViewModel(this._database) {
    _taskDao = _database.taskDao;
    _tasks = [];
    fetchTasks();
  }

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _taskDao.getTasksInChronologicalOrder();
    notifyListeners();
  }

  Future<bool> addTask(Task task) async {
    final existingTasks = _tasks.where(
          (e) => e.title == task.title && e.dueDateTime == task.dueDateTime,
    ).toList();

    if (existingTasks.isNotEmpty) {
      // Event(s) with the same title and start date/time already exist
      return false;
    } else {
      task.status = 'Not Started'; // Set the default status
      //task.priority = priority;
      await _taskDao.insertTask(task);
      _tasks.add(task); // Add the task to the local list
      notifyListeners();

      return true;
    }
  }


  Task getTaskByIndex(int index) {
    if (index >= 0 && index < _tasks.length) {
      final tasks = _tasks[index];


      return tasks;
    } else {
      throw Exception('Invalid task index');
    }
  }

  Future<void> deleteTask(Task task ) async {
    await _taskDao.deleteTask(task);
    _tasks.remove(task);
    //_events = await _eventDao.getEventsInChronologicalOrder();
    notifyListeners();
  }

  void updateTaskStatus(int index, String status) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index].status = status;
      notifyListeners();
    } else {
      throw Exception('Invalid task index');
    }
  }



  List<Task> getTodayTasks(){
    final currentDate = DateTime.now();
    final todayStart = DateTime(currentDate.year, currentDate.month, currentDate.day);
    final todayEnd = todayStart.add(Duration(days: 1));
    return _tasks.where((task) => task.dueDateTime.isAfter(todayStart) && task.dueDateTime.isBefore(todayEnd)).toList();
  }

  void addSampleTasks() async {
    final sampleTasks = [
      Task(
        title: 'Task 9',
        description: 'testing taks 0 ',
        dueDateTime: DateTime.now(),
        tags: 'work',
        priority:3,
        status:'Not started',

      ),

      Task(
        title: 'Task 8',
        description: 'testing taks 00 ',
        dueDateTime: DateTime.now(),
        tags: 'work',
        priority:2,
        status:'Not started',

      ),
      Task(
        title: 'Task 10',
        description: 'testing taks 1 ',
        dueDateTime: DateTime.now().add(Duration(days: 1)),
        tags: 'work',
        priority:1,
        status:'Not started',

      ),
      Task(
        title: 'Task 5',
        description: 'testing task 2',
        dueDateTime: DateTime.now().add(Duration(days: 2)),
        tags: 'work',
        priority:0,
        status:'Not started',
      ),

    ];

    for (final task in sampleTasks) {
      await addTask(task);
    }
  }
}
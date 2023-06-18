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
    final existingTasks= _tasks.where(
          (e) => e.title == task.title && e.dueDateTime == task.dueDateTime,
    ).toList();

    if (existingTasks.isNotEmpty) {
      // Event(s) with the same title and start date/time already exist
      return false;
    }
    else {
      await _taskDao.insertTask(task);
      _tasks.add(task); // Add the event to the local list
      notifyListeners();

      return true;
    }
  }


  Future<void> deleteTask(Task task ) async {
    await _taskDao.deleteTask(task);
    _tasks.remove(task);
    //_events = await _eventDao.getEventsInChronologicalOrder();
    notifyListeners();
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
        title: 'Task 0',
        description: 'testing taks 0 ',
        dueDateTime: DateTime.now(),
        tags: 'work',
        priority:0,
        status:'not started',

      ),

      Task(
        title: 'Task 00',
        description: 'testing taks 00 ',
        dueDateTime: DateTime.now(),
        tags: 'work',
        priority:1,
        status:'not started',

      ),
      Task(
        title: 'Task 1',
        description: 'testing taks 1 ',
        dueDateTime: DateTime.now().add(Duration(days: 1)),
        tags: 'work',
        priority:0,
        status:'not started',

      ),
      Task(
        title: 'Task 2',
        description: 'testing task 2',
        dueDateTime: DateTime.now().add(Duration(days: 2)),
        tags: 'work',
        priority:1,
        status:'not started',
      ),

    ];

    for (final task in sampleTasks) {
      await addTask(task);
    }
  }
}
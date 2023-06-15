import 'package:floor/floor.dart';
import 'task.dart';

@dao
abstract class TaskDao{

  @Query('SELECT * FROM Task ORDER BY due_date_time')
  Future<List<Task>> getTasksInChronologicalOrder();

  @Query('SELECT * FROM Task ORDER BY priority')
  Future<List<Task>> getTasksLowInPriorityOrder();

  @Query('SELECT * FROM Event WHERE due_date_time > :now')
  Future<List<Task>> getOngoingTasks(DateTime now);

  @Query('SELECT * FROM Task ORDER BY priority DESC')
  Future<List<Task>> getTasksInHighPriorityOrder();


  @Query('SELECT * FROM Task WHERE tags LIKE :tag')
  Future<List<Task>> getTasksByTag(String tag);


  @Query('SELECT * FROM Task WHERE status LIKE :status')
  Future<List<Task>> getTasksByStatus(String status);

  @Query('SELECT * FROM Task WHERE due_date_time = DATE("now")')
  Future<List<Task>> getTodayTasks();

  @Query('SELECT * FROM Task WHERE due_date_time >= DATE("now", "weekday 0", "-6 days") AND due_date_time <= DATE("now", "weekday 0")')
  Future<List<Task>> getThisWeekTasks();

  @Query('SELECT * FROM Task WHERE due_date_time >= DATE("now", "start of month") AND due_date_time <= DATE("now", "start of month", "+1 month", "-1 day")')
  Future<List<Task>> getThisMonthTasks();


  @insert
  Future<void> insertTask(Task task);

  @update
  Future<void> updateTask(Task task);

  @delete
  Future<void> deleteTask(Task task);
}
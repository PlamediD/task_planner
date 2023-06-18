import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'task_view_model.dart';
import 'delete.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool showAllTasks = false;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd hh:mm a');

    return Consumer<TaskViewModel>(
      builder: (context, taskViewModel, child) {
        final tasks = showAllTasks ? taskViewModel.tasks : taskViewModel.getTodayTasks();

        if (tasks.isEmpty) {
          return Center(
            child: Text('No tasks'),
          );
        } else {
          tasks.sort((a, b) => b.priority.compareTo(a.priority)); // Sort tasks by priority in descending order

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showAllTasks = !showAllTasks;
                      });
                    },
                    child: Text(
                      showAllTasks ? "Today's Tasks" : "All Tasks",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(task.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dateFormat.format(task.dueDateTime)),
                          Text(
                            'Status: ${task.status}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => DeleteTaskDialog(
                              taskTitle: task.title,
                              onConfirmDelete: () {
                                taskViewModel.deleteTask(task); // Delete the task
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

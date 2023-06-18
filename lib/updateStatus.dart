import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_view_model.dart';


class statusTracker extends StatelessWidget {
  final int taskIndex;

  statusTracker({required this.taskIndex});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskViewModel>(context);
    final selectedTask = taskProvider.getTaskByIndex(taskIndex);

    return Scaffold(
      appBar: AppBar(
        title: Text('Current Status of the Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task: ${selectedTask.title}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Current Status: ${selectedTask.status}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Update Status:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            DropdownButton<String>(
              value: selectedTask.status,
              onChanged: (newValue) {
                taskProvider.updateTaskStatus(taskIndex, newValue!);
              },
              items: <DropdownMenuItem<String>>[
                DropdownMenuItem<String>(
                  value: 'Not Started',
                  child: Text('Not Started'),
                ),
                DropdownMenuItem<String>(
                  value: 'In Progress',
                  child: Text('In Progress'),
                ),
                DropdownMenuItem<String>(
                  value: 'Done',
                  child: Text('Done'),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}

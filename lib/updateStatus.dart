/*
Author: Plamedi Diakubama
Date: 6/17/2023
Project: Task Planner app
Task Tracker is a productivity app that helps users organize and manage their daily tasks.
It provides a user-friendly interface with intuitive features to enhance productivity and efficiency.
Description: This file is responsible for updating task.status
User is provided with the three viable options 'Not started' , 'Done', 'In progress'
and they can select the one they want. Once selected, the status of the task will be updated on the screen
 */

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

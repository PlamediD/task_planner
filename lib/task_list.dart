/*
Author: Plamedi Diakubama
Date: 6/17/2023
Project: Task Planner app
Task Tracker is a productivity app that helps users organize and manage their daily tasks.
It provides a user-friendly interface with intuitive features to enhance productivity and efficiency.
Description: This file is for displaying the list of all tasks
By default, it only displays tasks that are due today but the user has the option to view all the tasks they have registered
In addition, it also displays icon next to each task to allow user to perform some modifications  (such as delete, modify status,
modify due date, modify priority, etc. )
 */

/*
Next to work on:
  - task registration
  - modify due date
  - task category ( based on common tags : I will limit it to 3 for simplicity: work, household, personal )
  - detail screen where user can now see every detail about a task
  Then work on testing

 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'task_view_model.dart';
import 'delete.dart';
import 'updateStatus.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

enum SortingOption {
  Priority,
  DueDateTime,
}

class _TaskListState extends State<TaskList> {
  bool showAllTasks = false;
  int selectedPriority = 0;
  String selectedTag = 'All';
  SortingOption selectedSortingOption = SortingOption.Priority;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd hh:mm a');

    return Consumer<TaskViewModel>(
      builder: (context, taskViewModel, child) {
        final tasks = showAllTasks
            ? taskViewModel.tasks
            : taskViewModel.getTodayTasks();
        final filteredTasks = tasks.where((task) {
          bool matchesPriority = selectedPriority == 0 || task.priority == selectedPriority;
          bool matchesTag = selectedTag == 'All' || task.tags.toLowerCase() == selectedTag.toLowerCase();
          return matchesPriority && matchesTag;
        }).toList();

        if (filteredTasks.isEmpty) {
          return Center(
            child: Text('No tasks'),
          );
        } else {
          filteredTasks.sort((a, b) {
            if (selectedSortingOption == SortingOption.Priority) {
              return b.priority.compareTo(a.priority);
            } else {
              return a.dueDateTime.compareTo(b.dueDateTime);
            }
          });

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
                      showAllTasks ? "Today" : "All Tasks",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  DropdownButton<int>(
                    value: selectedPriority,
                    onChanged: (value) {
                      setState(() {
                        selectedPriority = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem<int>(
                        value: 0,
                        child: Text('All Priority'),
                      ),
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Text('Priority 1'),
                      ),
                      DropdownMenuItem<int>(
                        value: 2,
                        child: Text('Priority 2'),
                      ),
                      DropdownMenuItem<int>(
                        value: 3,
                        child: Text('Priority 3'),
                      ),
                    ],
                  ),
                  DropdownButton<String>(
                    value: selectedTag,
                    onChanged: (value) {
                      setState(() {
                        selectedTag = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem<String>(
                        value: 'All',
                        child: Text('All tags'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Work',
                        child: Text('Work'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Household',
                        child: Text('Household'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Personal',
                        child: Text('Personal'),
                      ),
                    ],
                  ),
                  DropdownButton<SortingOption>(
                    value: selectedSortingOption,
                    onChanged: (value) {
                      setState(() {
                        selectedSortingOption = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem<SortingOption>(
                        value: SortingOption.Priority,
                        child: Text('Priority'),
                      ),
                      DropdownMenuItem<SortingOption>(
                        value: SortingOption.DueDateTime,
                        child: Text('Due Date'),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    final isHighPriority = task.priority == 3;
                    final isDone = task.status == 'Done';

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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => DeleteTaskDialog(
                                  taskTitle: task.title,
                                  onConfirmDelete: () {
                                    taskViewModel.deleteTask(task);
                                  },
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: isDone ? Icon(Icons.done) : Icon(Icons.info),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => statusTracker(
                                    taskIndex: index,
                                  ),
                                ),
                              );
                            },
                          ),
                          if (isHighPriority)
                            Icon(
                              Icons.priority_high,
                              color: Colors.red,
                            ),
                        ],
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

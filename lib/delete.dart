/*
Author: Plamedi Diakubama
Date: 6/17/2023
Project: Task Planner app
Task Tracker is a productivity app that helps users organize and manage their daily tasks.
It provides a user-friendly interface with intuitive features to enhance productivity and efficiency.
Description: This file is responsible for delete.
It allows the user to delete any specific task of their choice.

 */


import 'package:flutter/material.dart';


class DeleteTaskDialog extends StatelessWidget {
  final String taskTitle;
  final Function onConfirmDelete;

  DeleteTaskDialog({required this.taskTitle, required this.onConfirmDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Delete'),
      content: Text('Are you sure you want to delete $taskTitle?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            onConfirmDelete();
            Navigator.of(context).pop(true);
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}

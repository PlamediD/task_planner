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

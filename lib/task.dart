/*
Author: Plamedi Diakubama
Date: 6/14/2023
Project: Task Planner app
Task Tracker is a productivity app that helps users organize and manage their daily tasks.
It provides a user-friendly interface with intuitive features to enhance productivity and efficiency.
Description: This defines a task.
Each task includes task title/name, description, due date, priority level, and tags.
Priority goes from 0-3 ( with 0 being the less urgent and 3 being the most urgent)
Uses Floor for storage
 */

import 'package:floor/floor.dart';


@entity
class Task {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;
  final String description;
  final int priority;
  final String tags;
  String status;


  @ColumnInfo(name: 'due_date_time')
  final DateTime dueDateTime;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDateTime,
    required this.tags,
    required this.status,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    int? priority,
    DateTime? dueDateTime,
    String ?tags,
    String ? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      dueDateTime: dueDateTime ?? this.dueDateTime,
      tags: tags ?? this.tags,
      status:status ?? this.status,
    );
  }
}



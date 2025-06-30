import 'package:flutter/material.dart';

enum Priority {
  low,
  medium,
  high,
}

class Task {
  final String id;
  final String title;
  final String description;
  final Priority priority;
  bool isDone;
  final DateTime dueDate;
  final String tag;
  final String projectId;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    this.isDone = false,
    required this.dueDate,
    required this.tag,
    required this.projectId,
  });
}
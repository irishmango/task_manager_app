import 'package:flutter/material.dart';

enum Priority {
  low("low"),
  medium("middle"),
  high("high");

  const Priority(this.english);

  final String english;
}

// enum TodoIcon {
//   sport(Icons.sports),
//   food(Icons.dining),
//   meeting(Icons.group),
//   pets(Icons.pets),
//   doctor(Icons.medical_information),
//   shopping(Icons.shopping_cart);

//   const TodoIcon(this.icon);

//   final IconData icon;
// }

class Task {
  final String id;
  final String title;
  final String description;
  final Priority priority;
  final bool isDone;
  final DateTime dueDate;
  final String tag;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.isDone,
    required this.dueDate,
    required this.tag, 
  });
}
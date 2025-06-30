import 'package:todo_app/src/features/create/domain/tasks.dart';

class Project {
  final String id;
  final String title;
  final List<Task> todos;
  final String tag;

  Project({
    required this.id,
    required this.title,
    required this.todos,
    this.tag = "Project",
  });
}
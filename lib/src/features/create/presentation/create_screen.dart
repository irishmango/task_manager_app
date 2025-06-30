import 'package:flutter/material.dart';
import 'package:todo_app/src/features/create/domain/project.dart';
import 'package:todo_app/src/features/create/domain/tasks.dart';
import 'package:todo_app/src/features/create/presentation/widgets/create_project_card.dart';
import 'package:todo_app/src/features/create/presentation/widgets/create_task_card.dart';
import 'package:todo_app/src/features/create/presentation/widgets/priority_icon.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _projectTitleController = TextEditingController();
  final TextEditingController _projectDescriptionController = TextEditingController();

  String selectedPriority = 'Low';
  String selectedCategory = 'Personal';

  List<String> _projectTasks = [];

  void _showTaskDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String tempPriority = 'Low';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8, 
          child: CreateTaskCard(
            titleController: titleController,
            descriptionController: descriptionController,
            selectedPriority: tempPriority,
            onPrioritySelected: (priority) {
              tempPriority = priority;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _projectTasks.add(titleController.text);
              });
              Navigator.of(context).pop();
            },
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

    void _createTask() {
    if (selectedCategory == 'Personal') {
      final task = Task(
        id: DateTime.now().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        priority: selectedPriority == 'Low'
            ? Priority.low
            : selectedPriority == 'Medium'
                ? Priority.medium
                : Priority.high,
        isDone: false,
        dueDate: DateTime(2066),
        tag: selectedCategory, projectId: '',
      );
      Navigator.pop(context, task);
    } else if (selectedCategory == 'Project') {
      final project = Project(
        id: DateTime.now().toString(),
        title: _projectTitleController.text,
        todos: _projectTasks.map((title) => Task(
          id: DateTime.now().toString(),
          title: title,
          description: '',
          priority: Priority.low,
          isDone: false,
          dueDate: DateTime(2066),
          tag: 'Project', projectId: '',
        )).toList(), ownerId: '',
      );
      Navigator.pop(context, project);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Create', style: TextStyle(color: Colors.white, fontSize: 32)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: ['Personal', 'Project', 'Collaboration'].map((category) {
                final isSelected = category == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Color.fromRGBO(28, 125, 28, 1) : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            if (selectedCategory == 'Personal')
              CreateTaskCard(
                titleController: _titleController,
                descriptionController: _descriptionController,
                selectedPriority: selectedPriority,
                onPrioritySelected: (priority) {
                  setState(() {
                    selectedPriority = priority;
                  });
                },
              )
            else if (selectedCategory == 'Project')
              CreateProjectCard(
                projectTitleController: _projectTitleController,
                projectDescriptionController: _projectDescriptionController,
                selectedPriority: selectedPriority,
                onPrioritySelected: (priority) {
                  setState(() {
                    selectedPriority = priority;
                  });
                },
                projectTasks: _projectTasks,
                onAddTaskPressed: _showTaskDialog,
              )
            else
              const Text("Collaboration coming soon", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(28, 125, 28, 1),
                foregroundColor: Colors.black,
              ),
              child: const Text("Create"),
            )
          ],
        ),
      ),
    );
  }
}

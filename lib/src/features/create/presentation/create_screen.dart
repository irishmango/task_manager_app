import 'package:flutter/material.dart';
import 'package:todo_app/src/features/create/domain/project.dart';
import 'package:todo_app/src/features/create/domain/tasks.dart';
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
        tag: selectedCategory,
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
          tag: 'Project',
        )).toList(),
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
                          color: isSelected ? const Color.fromRGBO(254, 203, 93, 1) : Colors.transparent,
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
                backgroundColor: const Color.fromRGBO(254, 203, 93, 1),
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

class CreateTaskCard extends StatelessWidget {
  const CreateTaskCard({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.selectedPriority,
    required this.onPrioritySelected,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String selectedPriority;
  final Function(String) onPrioritySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Title:',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            
            children: [
              PriorityIcon(
                label: "Low",
                color: Colors.green,
                isSelected: selectedPriority == 'Low',
                onTap: () => onPrioritySelected('Low'),
              ),
              const SizedBox(height: 10),
              PriorityIcon(
                label: "Medium",
                color: Colors.orange,
                isSelected: selectedPriority == 'Medium',
                onTap: () => onPrioritySelected('Medium'),
              ),
              const SizedBox(height: 10),
              PriorityIcon(
                label: "High",
                color: Colors.red,
                isSelected: selectedPriority == 'High',
                onTap: () => onPrioritySelected('High'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CreateProjectCard extends StatelessWidget {
  const CreateProjectCard({
    super.key,
    required this.projectTitleController,
    required this.projectDescriptionController,
    required this.selectedPriority,
    required this.onPrioritySelected,
    required this.projectTasks,
    required this.onAddTaskPressed,
  });

  final TextEditingController projectTitleController;
  final TextEditingController projectDescriptionController;
  final String selectedPriority;
  final Function(String) onPrioritySelected;
  final List<String> projectTasks;
  final VoidCallback onAddTaskPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: projectTitleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Title:',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: projectDescriptionController,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 10),
                ...projectTasks.map((task) => Text(
                      "• $task",
                      style: const TextStyle(color: Colors.white),
                    )),
                
                const SizedBox(height: 20),
                CustomOutlinedButton(label: "Add Task", onPressed: onAddTaskPressed),
              ],
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white, width: 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        textStyle: const TextStyle(fontSize: 14),
      ),
      child: Text(label),
    );
  }
}
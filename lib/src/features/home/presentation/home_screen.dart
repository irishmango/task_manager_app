import 'package:flutter/material.dart';
import 'package:task_manager_app/src/features/create/domain/project.dart';
import 'package:task_manager_app/src/features/create/domain/tasks.dart';
import 'package:task_manager_app/src/features/create/presentation/create_screen.dart';
import 'package:task_manager_app/src/features/home/presentation/widgets/main_card.dart';
import 'package:task_manager_app/src/features/profile/presentation/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = "All";
  final List<String> filters = ["All", "Personal", "Projects", "Collaborations"];

  final List<Project> projects = [
    Project(id: "987",
        title: "RPG App",
        todos: [
          Task(id: "125", title: "Create Character Sheet", description: "", priority: Priority.low, isDone: false, dueDate: DateTime(2066), tag: "", projectId: ''),
          Task(id: "126", title: "Add Edit Functionality", description: "", priority: Priority.low, isDone: false, dueDate: DateTime(2066), tag: "", projectId: '')
        ], ownerId: ''),
    Project(id: "986",
        title: "Todo App",
        todos: [
          Task(id: "127", title: "Finish Create Screen", description: "", priority: Priority.low, isDone: false, dueDate: DateTime(2066), tag: "", projectId: ''),
          Task(id: "128", title: "Implement Firebase", description: "", priority: Priority.low, isDone: false, dueDate: DateTime(2066), tag: "", projectId: '')
        ], ownerId: ''),
  ];

  final List<Task> tasks = [
    Task(id: "123", title: "Finish Installing Firebase", description: "Follow instructions from lecture notes", priority: Priority.low, isDone: false, dueDate: DateTime(2066), tag: "Personal", projectId: ''),
    Task(id: "124", title: "Pay Phone Bill", description: "Overdue from last month", priority: Priority.high, isDone: false, dueDate: DateTime(2066), tag: "Personal", projectId: '')
  ];

  String getTitle() {
    switch (selectedFilter) {
      case 'All':
        return 'All Tasks';
      case 'Projects':
        return 'Your Projects';
      case 'Personal':
        return 'Personal Tasks';
      case 'Collaborations':
        return 'Collaborations';
      default:
        return 'Tasks';
    }
  }

  @override
  Widget build(BuildContext context) {
    late final List<Map<String, dynamic>> shownList;
    if (selectedFilter == "All") {
      shownList = [
        ...projects.map((project) => {'type': 'project', 'data': project}),
        ...tasks.map((task) => {'type': 'task', 'data': task}),
      ];
    } else if (selectedFilter == "Personal") {
      shownList = tasks.map((task) => {'type': 'task', 'data': task}).toList();
    } else if (selectedFilter == "Projects") {
      shownList = projects.map((project) => {'type': 'project', 'data': project}).toList();
    } else {
      shownList = [];
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTitle(),
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                    },
                    icon: Icon(Icons.person, size: 48, color: Color.fromRGBO(28, 125, 28, 1)),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final filter = filters[index];
                    final isSelected = filter == selectedFilter;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected ? Border.all(color: Color.fromRGBO(28, 125, 28, 1)) : Border.all(color: Colors.transparent),
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: shownList.length,
                  itemBuilder: (context, index) {
                    final item = shownList[index];
                    if (item['type'] == 'project') {
                      final project = item['data'] as Project;
                      return MainCard(
                        tag: 'Project',
                        title: project.title,
                        tasks: project.todos.map((t) => t.title).toList(),
                      );
                    } else if (item['type'] == 'task') {
                      final task = item['data'] as Task;
                      return MainCard(
                        tag: task.tag,
                        title: task.title,
                        tasks: [task.description],
                      );
                    }
                    return SizedBox(
                      child: Text("Nothing to do!"),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(28, 125, 28, 1),
        foregroundColor: Colors.white,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateScreen()),
          );

          if (result != null) {
            setState(() {
              if (result is Task) {
                tasks.add(result);
              } else if (result is Project) {
                projects.add(result);
              }
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
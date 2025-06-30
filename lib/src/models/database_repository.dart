import 'package:todo_app/src/features/create/domain/tasks.dart';
import 'package:todo_app/src/features/create/domain/project.dart';
import 'package:todo_app/src/features/auth/domain/user.dart';

abstract class DatabaseRepository {

  Future<List<Project>> getProjects(String userId);
  Future<void> createProject(String userId, Project project);
  Future<void> deleteProject(String userId, String projectId);

  Future<List<Task>> getTasks(String projectId);
  Future<void> createTask(String projectId, Task task);
  Future<void> checkTask(String projectId, String taskId);
  Future<void> uncheckTask(String projectId, String taskId);


  Future<void> createAppUser(AppUser appUser);
  Future<AppUser> getUser(String userId);
}
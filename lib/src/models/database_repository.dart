

import 'package:todo_app/src/features/create/domain/tasks.dart';

abstract class DatabaseRepository {
  // Groups
  // Future<List<Group>> getGroups(String userId);
  // Future<void> createGroup(String userId, Group group);
  // Future<void> deleteGroup(String userId, String groupId);
  // Future<Group> joinGroup(String userId, String groupId);

  // Todos
  Future<List<Task>> getTasks(String groupId);
  Future<void> createTodo(String groupId, Task todo);
  Future<void> checkTodo(String groupId, String todoId);
  Future<void> uncheckTodo(String groupId, String todoId);

  // AppUser
  Future<void> createAppUser(AppUser appUser);
  Future<AppUser> getUser(String userId);
}

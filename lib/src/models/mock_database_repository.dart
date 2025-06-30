import 'package:flutter/material.dart';
import 'package:task_manager_app/src/features/auth/domain/user.dart';
import 'package:task_manager_app/src/features/create/domain/project.dart';
import 'package:task_manager_app/src/features/create/domain/tasks.dart';

import 'database_repository.dart';

class MockDatabaseRepository implements DatabaseRepository {
  final List<Task> _taskList = [];
  final List<Project> _projectList = [];
  final List<AppUser> _userList = [];


  @override
  Future<List<Project>> getProjects(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _projectList.where((project) => project.ownerId == userId).toList();
  }

  @override
  Future<void> createProject(String userId, Project project) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final projectWithOwner = Project(
      id: project.id,
      title: project.title,
      todos: project.todos,
      ownerId: userId,
      tag: project.tag,
    );
    _projectList.add(projectWithOwner);
  }

  @override
  Future<void> deleteProject(String userId, String projectId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _projectList.removeWhere(
        (project) => project.id == projectId && project.ownerId == userId);
    _taskList.removeWhere((task) => task.projectId == projectId);
  }


  @override
  Future<List<Task>> getTasks(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _taskList.where((task) => task.projectId == projectId).toList();
  }

  @override
  Future<void> createTask(String projectId, Task task) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _taskList.add(task);
  }

  @override
  Future<void> checkTask(String projectId, String taskId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final task = _taskList.firstWhere((t) => t.id == taskId);
    task.isDone = true;
  }

  @override
  Future<void> uncheckTask(String projectId, String taskId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final task = _taskList.firstWhere((t) => t.id == taskId);
    task.isDone = false;
  }

  // Users

  @override
  Future<void> createAppUser(AppUser appUser) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _userList.add(appUser);
  }

  @override
  Future<AppUser> getUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _userList.firstWhere((user) => user.id == userId);
  }
  
}
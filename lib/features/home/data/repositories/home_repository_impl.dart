import 'package:ingetin_task_reminder_app/features/home/data/datasources/home_service.dart';
import 'package:ingetin_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeService service = HomeService();
  FirebaseAuth user = FirebaseAuth.instance;

  @override
  Future<void> saveTask(Task task) {
    return service.addTask(task);
  }

  @override
  Future<List<Task>> retrieveTask() {
    return service.retrieveTask();
  }

  @override
  Future<List<Task>> retrieveTaskCompleted() {
    return service.retrieveTaskCompleted();
  }

  @override
  Future<List<Task>> retrieveImportantTask() {
    return service.retrieveImportantTask();
  }

  @override
  Future<List<Task>> retrievePlannedTask() {
    return service.retrievePlannedTask();
  }

  @override
  Future<List<Task>> retrieveGroceriesTask() {
    return service.retrieveGroceriesTask();
  }

  @override
  Future<void> flagTask(Task task) {
    return service.flagTask(task);
  }

  @override
  Future<void> flagImportantTask(Task task) {
    return service.flagImportantTask(task);
  }

  @override
  Future<void> updateTask(Task task) {
    return service.updateTask(task);
  }

  @override
  Future<List<Task>> retrieveAllTask() {
    return service.retrieveAllTask();
  }

  @override
  Future<List<Task>> retrieveAllTaskCompleted() {
    return service.retrieveAllTaskCompleted();
  }
}

abstract class HomeRepository {
  Future<void> saveTask(Task task);
  Future<void> flagTask(Task task);
  Future<void> flagImportantTask(Task task);
  Future<void> updateTask(Task task);
  Future<List<Task>> retrieveTask();
  Future<List<Task>> retrieveTaskCompleted();
  Future<List<Task>> retrieveAllTask();
  Future<List<Task>> retrieveAllTaskCompleted();
  Future<List<Task>> retrieveImportantTask();
  Future<List<Task>> retrieveGroceriesTask();
  Future<List<Task>> retrievePlannedTask();
}

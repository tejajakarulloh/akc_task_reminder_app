import 'package:akc_task_reminder_app/features/home/data/datasources/home_service.dart';
import 'package:akc_task_reminder_app/features/home/data/models/task_model.dart';
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
  Future<void> flagTask(Task task) {
    return service.flagTask(task);
  }
}

abstract class HomeRepository {
  Future<void> saveTask(Task task);
  Future<void> flagTask(Task task);
  Future<List<Task>> retrieveTask();
}

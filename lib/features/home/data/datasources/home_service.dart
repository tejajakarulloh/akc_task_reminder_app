import 'package:akc_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addTask(Task task) async {
    await _db.collection("Tasks").add(task.toJson());
  }

  Future<List<Task>> retrieveTask() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Tasks")
        .where('completed', isEqualTo: false)
        .where('date',
            isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
        .get();
    return snapshot.docs
        .map((docSnapshot) => Task.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<Task>> retrieveTaskCompleted() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Tasks")
        .where('completed', isEqualTo: true)
        .where('date',
            isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
        .get();
    return snapshot.docs
        .map((docSnapshot) => Task.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<void> flagTask(Task task) async {
    return await _db.collection("Tasks").doc(task.id).set(task.toJson());
  }

  Future<void> flagImportantTask(Task task) async {
    return await _db.collection("Tasks").doc(task.id).set(task.toJson());
  }

  Future<List<Task>> retrieveImportantTask() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Tasks")
        .where('completed', isEqualTo: false)
        .where('important', isEqualTo: true)
        .get();
    return snapshot.docs
        .map((docSnapshot) => Task.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}

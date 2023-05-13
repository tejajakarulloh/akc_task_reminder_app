import 'package:akc_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addTask(Task task) async {
    await _db.collection("Tasks").add(task.toJson());
  }

  Future<List<Task>> retrieveTask() async {
    final Timestamp yesterday =
        Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 1)));
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Tasks")
        .where('completed', isEqualTo: false)
        .where('date', isLessThan: Timestamp.fromDate(DateTime.now()))
        .where('date', isGreaterThan: yesterday)
        .get();
    return snapshot.docs
        .map((docSnapshot) => Task.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<Task>> retrieveTaskCompleted() async {
    final Timestamp yesterday =
        Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 1)));
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Tasks")
        .where('completed', isEqualTo: true)
        .where('date', isLessThan: Timestamp.fromDate(DateTime.now()))
        .where('date', isGreaterThan: yesterday)
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

  Future<List<Task>> retrievePlannedTask() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Tasks")
        .where('completed', isEqualTo: false)
        .where('date', isGreaterThan: Timestamp.fromDate(DateTime.now()))
        .get();
    return snapshot.docs
        .map((docSnapshot) => Task.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<Task>> retrieveGroceriesTask() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Tasks")
        .where('completed', isEqualTo: false)
        .where('category', isEqualTo: 'Groceries')
        .get();
    return snapshot.docs
        .map((docSnapshot) => Task.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<void> updateTask(Task task) async {
    return await _db.collection("Tasks").doc(task.id).set(task.toJson());
  }
}

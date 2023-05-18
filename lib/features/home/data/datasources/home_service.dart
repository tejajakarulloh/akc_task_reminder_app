import 'package:ingetin_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addTask(Task task) async {
    await _db.collection("Tasks").add(task.toJson());
  }

  Future<List<Task>> retrieveTask() async {
    DateTime startOfToday =
        DateTime.parse('${DateTime.now().toString().split(' ')[0]} 00:00:00');
    DateTime endOfToday =
        DateTime.parse('${DateTime.now().toString().split(' ')[0]} 23:59:59');
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Tasks")
        .where('completed', isEqualTo: false)
        .where('date', isLessThan: endOfToday)
        .where('date', isGreaterThan: startOfToday)
        .get();
    return snapshot.docs
        .map((docSnapshot) => Task.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<Task>> retrieveTaskCompleted() async {
    DateTime startOfToday =
        DateTime.parse('${DateTime.now().toString().split(' ')[0]} 00:00:00');
    DateTime endOfToday =
        DateTime.parse('${DateTime.now().toString().split(' ')[0]} 23:59:59');
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Tasks")
        .where('completed', isEqualTo: true)
        .where('date', isLessThan: endOfToday)
        .where('date', isGreaterThan: startOfToday)
        .get();
    return snapshot.docs
        .map((docSnapshot) => Task.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<Task>> retrieveAllTask() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Tasks")
        .where('completed', isEqualTo: false)
        .get();
    return snapshot.docs
        .map((docSnapshot) => Task.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<Task>> retrieveAllTaskCompleted() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Tasks").where('completed', isEqualTo: true).get();
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
    DateTime nextDay = DateTime.parse(
        '${DateTime.now().subtract(const Duration(days: 1)).toString().split(' ')[0]} 00:00:00');

    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("Tasks")
        .where('completed', isEqualTo: false)
        .where('date', isGreaterThan: Timestamp.fromDate(nextDay))
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

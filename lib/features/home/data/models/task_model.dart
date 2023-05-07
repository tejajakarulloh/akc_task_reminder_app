import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  String uid;
  String task;
  String? category;
  DateTime? date;
  bool? reminder;
  DateTime? reminderAt;
  String? repeat;
  String? repeatEvery;
  String? note;
  bool completed;

  Task({
    this.id,
    required this.uid,
    required this.task,
    this.category,
    this.date,
    this.reminder,
    this.reminderAt,
    this.repeat,
    this.repeatEvery,
    this.note,
    required this.completed,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['task'] = task;
    data['category'] = category;
    data['date'] = date;
    data['reminder'] = reminder;
    data['reminderAt'] = reminderAt;
    data['repeat'] = repeat;
    data['repeatEvery'] = repeatEvery;
    data['note'] = note;
    data['completed'] = completed;
    return data;
  }

  Task.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        uid = doc.data()!["uid"],
        task = doc.data()!["task"],
        category = doc.data()!["category"],
        date = doc.data()!["date"],
        reminder = doc.data()!["reminder"],
        reminderAt = doc.data()!["reminderAt"],
        repeat = doc.data()!["repeat"],
        repeatEvery = doc.data()!["repeatEvery"],
        note = doc.data()!["note"],
        completed = doc.data()!["completed"];
}

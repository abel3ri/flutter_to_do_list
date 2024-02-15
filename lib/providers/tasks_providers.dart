import 'package:firebase_local/utils/constants.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';

class TasksProvider with ChangeNotifier {
  int? tasksNum;
  Future<void> numOfTasks() async {
    final res = await db.collection("tasks").get();
    tasksNum = res.docs.length;
    notifyListeners();
  }

  Future<void> toggleCheckBoxState(String id, bool value) async {
    await db.collection("tasks").doc(id).update({"taskState": value});
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await db.collection("tasks").add({
      "id": task.id,
      "taskName": task.taskName,
      "taskState": task.taskState,
    });
    notifyListeners();
  }

  Future<void> editTask(Task task) async {
    await db.collection("tasks").doc(task.id).update({
      "taskName": task.taskName,
    });
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    await db.collection("tasks").doc(id).delete();
    notifyListeners();
  }
}

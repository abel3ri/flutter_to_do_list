import 'package:firebase_local/models/task.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  Task? _task;
  void addTaskInfo(Task task) {
    _task = task;
    notifyListeners();
  }

  Task task() => _task!;
}

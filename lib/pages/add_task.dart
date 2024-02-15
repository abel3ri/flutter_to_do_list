// ignore_for_file: must_be_immutable

import 'package:firebase_local/models/task.dart';
import 'package:firebase_local/providers/tasks_providers.dart';
import 'package:firebase_local/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatefulWidget {
  AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController _controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TasksProvider>(context);

    return Container(
      width: AppConstants.deviceHeight(context),
      padding: EdgeInsets.only(
        top: 0,
        right: 24,
        left: 24,
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              "Add Task",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) return "Please enter a task name";
                return null;
              },
              decoration: InputDecoration(
                hintText: "Task name",
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Task task = Task(taskName: _controller.text);
                  taskProvider.addTask(task);

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Successfuly added a task."),
                  ));
                  Navigator.of(context).pop();
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColor,
                ),
                foregroundColor: MaterialStateProperty.all(
                  Colors.white,
                ),
              ),
              child: Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}

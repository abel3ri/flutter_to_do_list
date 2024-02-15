// ignore_for_file: must_be_immutable

import 'package:firebase_local/models/task.dart';
import 'package:firebase_local/providers/task_provider.dart';
import 'package:firebase_local/providers/tasks_providers.dart';
import 'package:firebase_local/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTaskPage extends StatefulWidget {
  EditTaskPage({super.key});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  TextEditingController _controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = Provider.of<TaskProvider>(context).task().taskName;
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
              "Edit Task",
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
                  Task task = Task(
                    taskName: _controller.text,
                    id: Provider.of<TaskProvider>(context, listen: false)
                        .task()
                        .id,
                    taskState: Provider.of<TaskProvider>(context, listen: false)
                        .task()
                        .taskState,
                  );
                  taskProvider.editTask(task);

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Successfuly edited a task."),
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
              child: Text("Edit"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_local/models/task.dart';
import 'package:firebase_local/pages/edit_task.dart';
import 'package:firebase_local/providers/task_provider.dart';
import 'package:firebase_local/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/tasks_providers.dart';

class TaskList extends StatelessWidget {
  TaskList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TasksProvider>(context);

    return FutureBuilder(
      future: db.collection("tasks").get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemCount: (snapshot.data as QuerySnapshot).docs.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(snapshot.data!.docs[index]),
                onDismissed: (direction) {
                  taskProvider.deleteTask(snapshot.data!.docs[index].id);
                  taskProvider.numOfTasks();
                },
                background: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.only(right: 20),
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                direction: DismissDirection.endToStart,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.15,
                        color: Theme.of(context).textTheme.bodyMedium!.color!,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Provider.of<TaskProvider>(context, listen: false)
                                  .addTaskInfo(
                                Task(
                                  taskName: snapshot.data!.docs[index]
                                      .data()['taskName'],
                                  id: snapshot.data!.docs[index].id,
                                  taskState: snapshot.data!.docs[index]
                                      .data()['taskState'],
                                ),
                              );
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => EditTaskPage(),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                showDragHandle: true,
                                isScrollControlled: true,
                                useSafeArea: true,
                              );
                            },
                            icon: const Icon(Icons.edit),
                            iconSize: 20,
                          ),
                          Text(
                            snapshot.data!.docs[index].data()['taskName'],
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      decoration: snapshot.data!.docs[index]
                                              .data()['taskState']
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                          ),
                        ],
                      ),
                      Checkbox(
                        value: snapshot.data!.docs[index].data()['taskState'],
                        onChanged: (value) {
                          taskProvider.toggleCheckBoxState(
                            snapshot.data!.docs[index].id,
                            value!,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: Text(
              "No tasks found. Try adding one.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
      },
    );
  }
}

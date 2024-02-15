import 'package:firebase_local/utils/constants.dart';
import 'package:flutter/material.dart';
import '../pages/add_task.dart';
import '../utils/widgets/task_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskPage(),
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
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, left: 30, bottom: 30),
            width: AppConstants.deviceWidth(context),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  icon: CircleAvatar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    radius: 30,
                    child: Icon(
                      Icons.menu,
                      size: 35,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                ),
                Text(
                  "To-Do List",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 5),
                FutureBuilder(
                    future: db.collection("tasks").get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          width: (Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize)! +
                              2,
                          height: (Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize)! +
                              2,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      } else {
                        return Text(
                          snapshot.data!.docs.length == 1
                              ? "1 task"
                              : "${snapshot.data!.docs.length} tasks",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        );
                      }
                    }),
              ],
            ),
          ),
          Expanded(
            child: TaskList(),
          ),
        ],
      ),
    );
  }
}

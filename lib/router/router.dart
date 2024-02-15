import 'package:firebase_local/pages/add_task.dart';
import 'package:firebase_local/pages/edit_task.dart';
import 'package:firebase_local/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        name: "home",
        builder: (context, state) => Home(),
      ),
      GoRoute(
        path: "/add",
        name: "add",
        builder: (context, state) => AddTaskPage(),
      ),
      GoRoute(
        path: "/edit",
        name: "edit",
        builder: (context, state) => EditTaskPage(),
      )
    ],
    errorBuilder: (context, state) => Container(
      child: Center(
        child: Text(
          "Page not found.",
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}

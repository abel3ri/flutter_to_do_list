// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_local/firebase_options.dart';
import 'package:firebase_local/providers/task_provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import './providers/tasks_providers.dart';
import './utils/constants.dart';
import './router/router.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (useEmulator) {
    db.useFirestoreEmulator(host, 8080);
    db.settings = const Settings(
      persistenceEnabled: false,
    );
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TasksProvider()),
      ChangeNotifierProvider(create: (context) => TaskProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: PageRouter.router,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: FlexThemeData.light(
        useMaterial3: true,
        scheme: FlexScheme.red,
        primary: Colors.redAccent,
        secondary: Colors.white,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        useMaterial3: true,
        scheme: FlexScheme.red,
        primary: Colors.redAccent,
        secondary: Colors.white,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      // builder: (context, child) =>  Home(),
    );
  }
}

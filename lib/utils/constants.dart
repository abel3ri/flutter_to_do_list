import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static double deviceHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static double deviceWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static double statusBarHeight(context) {
    return MediaQuery.of(context).padding.top;
  }
}

String host = Platform.isAndroid ? "10.0.2.2" : "localhost";
bool useEmulator = false;

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

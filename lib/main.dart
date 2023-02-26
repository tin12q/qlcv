import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qlcv/model/color_picker.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'model/color_picker.dart';
import 'model/db_helper.dart';
//import 'model/task.dart';

import 'route/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => SignInPage(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

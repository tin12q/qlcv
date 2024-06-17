import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
//import 'model/task.dart';
import 'route/calendar.dart';
import 'model/db_helper.dart';
import 'route/login_page.dart';
import 'dart:async';

Timer? timer;
bool isPaused = false;



void main() async {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => SignInPage(),
      '/home': (context) => const HomePage(),
    },
    debugShowCheckedModeBanner: false,
  ));
  timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
    print(isPaused);
    if (!isPaused) {
      DBHelper.resetAndFetchData();
    }
  });
}

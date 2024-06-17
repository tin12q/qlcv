import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
//import 'model/task.dart';

import 'model/db_helper.dart';
import 'route/login_page.dart';
import 'dart:async';

Timer? timer;
bool isPaused = false;
void resetAndFetchData() async {
  DBHelper.reset();
  await DBHelper.getEmp();
  await DBHelper.getDep();
  await DBHelper.taskUpdate();
  await DBHelper.getProject();
  await DBHelper.getAvatar();
  DBHelper.initMap();
  DBHelper.updateTaskEMP();
  DBHelper.projectTasks.clear();
}


void main() async {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => SignInPage(),
      '/home': (context) => const HomePage(),
    },
    debugShowCheckedModeBanner: false,
  ));
  timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
    print(isPaused);
    if (!isPaused) {
      resetAndFetchData();
    }
  });
}

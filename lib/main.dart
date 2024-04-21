import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
//import 'model/task.dart';

import 'route/login_page.dart';

void main() async {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => SignInPage(),
      '/home': (context) => const HomePage(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

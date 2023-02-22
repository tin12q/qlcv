import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'model/data_proc.dart';
//import 'model/task.dart';

import 'route/home.dart';
import 'route/calendar.dart';
import 'route/menu.dart';
import 'package:qlcv/model/color_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DataProc.TaskUpdate();
  //print(DataProc.tasks.first);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Calendar(),
    Menu(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: ColorPicker.primary,
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            body: _widgetOptions.elementAt(_selectedIndex),
            /*bottomNavigationBar: BottomNavigationBar(

              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined),
                  label: 'Calendar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_outlined),
                  label: 'School',
                ),
              ],

              backgroundColor: ColorPicker.accent,
              unselectedItemColor: ColorPicker.primary,
              selectedItemColor: ColorPicker.primaryLight,
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            )*/
            bottomNavigationBar: SafeArea(
              child: GNav(
                gap: 8,
                activeColor: ColorPicker.primaryLight,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                duration: Duration(milliseconds: 300),
                tabBackgroundColor: ColorPicker.accent,
                tabs: [
                  GButton(
                    icon: Icons.home_outlined,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.calendar_month_outlined,
                    text: 'Calendar',
                  ),
                  GButton(
                    icon: Icons.menu_outlined,
                    text: 'Menu',
                  ),
                ],
                selectedIndex: 0,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            )));
  }
}

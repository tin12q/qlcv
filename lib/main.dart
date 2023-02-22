import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'model/db_helper.dart';
//import 'model/task.dart';

import 'route/dashboard.dart';
import 'route/home.dart';
import 'route/calendar.dart';
import 'route/menu.dart';
import 'package:qlcv/model/color_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DBHelper.taskUpdate();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Home(),
    Calendar(),
    const Menu(),

  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: ColorPicker.background,

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
            bottomNavigationBar: Container(
              color: ColorPicker.primary,
          child:SafeArea(
              child: GNav(
                gap: 5,
                activeColor: ColorPicker.primary,
                color: ColorPicker.dark,
                rippleColor: ColorPicker.primary,
                hoverColor: ColorPicker.accent,
                iconSize: 19,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                duration: const Duration(milliseconds: 300),
                tabBackgroundColor: ColorPicker.accent,
                backgroundColor: ColorPicker.primary,

                tabs: const [
                  GButton(
                    icon: Icons.dashboard_outlined,


                  ),
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
            )))
    );}
}

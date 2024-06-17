import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:qlcv/model/emp.dart';
import 'model/db_helper.dart';

//import 'model/task.dart';

import 'route/dashboard.dart';
import 'route/home.dart';
import 'route/calendar.dart';
import 'route/menu.dart';
import 'route/projects.dart';
import 'package:qlcv/model/color_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _dataLoaded = false;
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    const Home(),
    const Projects(),
    const Calendar(),
    const Menu(),
  ];

  Future<void> loadData() async {
    if (!_dataLoaded) {
      DBHelper.reset();
      await DBHelper.getEmp();
      await DBHelper.getDep();
      await DBHelper.taskUpdate();
      await DBHelper.getProject();
      await DBHelper.getAvatar();
      DBHelper.initMap();
      DBHelper.updateTaskEMP();
      DBHelper.projectTasks.clear();
      setState(() {
        _dataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_dataLoaded) {
      loadData();
      return const Center(
        child: CircularProgressIndicator(
          color: ColorPicker.accent,
          backgroundColor: ColorPicker.background,
        ),
      );
    }
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        color: ColorPicker.primary,
        child: SafeArea(
          child: GNav(
            gap: 5,
            activeColor: ColorPicker.primary,
            color: ColorPicker.dark,
            rippleColor: ColorPicker.primary,
            hoverColor: ColorPicker.accent,
            iconSize: 19,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20), // Adjust the horizontal padding here
            duration: const Duration(milliseconds: 300),
            tabBackgroundColor: ColorPicker.accent,
            backgroundColor: ColorPicker.primary,
            tabs: _tabs,
            selectedIndex: 1,
            onTabChange: (index)  async {
              await DBHelper.taskUpdate();
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  final _tabs = (Platform.isIOS)
      ? const [
    GButton(
      icon: CupertinoIcons.square_grid_2x2,
      iconSize: 25,
    ),
    // GButton for Project
    
    GButton(
      icon: CupertinoIcons.home,
      iconSize: 25,
      text: 'Home',
    ),
    GButton(
      icon: CupertinoIcons.calendar_today,
      iconSize: 25,
      text: 'Calendar',
    ),
    GButton(
      icon: CupertinoIcons.bars,
      iconSize: 25,
    ),
  ]
      : const [
    GButton(
      icon: Icons.dashboard_outlined,
    ),
    GButton(
      icon: Icons.home_outlined,

      text: 'Home',
    ),
    GButton(
        icon: Icons.cases_outlined,
        text: 'Project'
    ),

    GButton(
      icon: Icons.calendar_month_outlined,
      text: 'Calendar',
    ),
    GButton(
      icon: Icons.menu_outlined,
      text: 'Menu',
    )
  ];
}
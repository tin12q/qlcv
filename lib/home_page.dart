import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
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
class HomePage extends StatefulWidget {

  void loadData() async
  {
    await DBHelper.taskUpdate();
  }
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Home(),
    Calendar(),
    const Menu(),

  ];

  //future build
  @override
  initState() {
    super.initState();
    widget.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 20),
                duration: const Duration(milliseconds: 300),
                tabBackgroundColor: ColorPicker.accent,
                backgroundColor: ColorPicker.primary,

                tabs: _tabs,
                selectedIndex: 1,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            )
        ));
    }
    final _tabs = (Platform.isIOS) ? const [
      GButton(icon: CupertinoIcons.square_grid_2x2),
      GButton(icon: CupertinoIcons.home,
        text: 'Home',),
      GButton(icon: CupertinoIcons.calendar_today
        , text: 'Calendar',),
      GButton(icon: CupertinoIcons.bars
        , text: 'Menu',),

    ] : const [
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

      )
    ];
}

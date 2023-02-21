import 'package:flutter/material.dart';
import 'model/task.dart';
import 'model/task_box.dart';
import 'route/home.dart';
import 'route/calendar.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>{
  int _selectedIndex = 0;
  List<Task> task = [
    Task(title: 'Task 1', description: ''
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', status: 'Status 1', date: DateTime.now()),
    Task(title: 'Task 2', description: 'Description 2', status: 'Status 2', date: DateTime.now()),
    Task(title: 'Task 3', description: 'Description 3', status: 'Status 3', date: DateTime.now())
  ];
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Calendar()
  ];
  _MyAppState({Key? key}): super();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(

            body: _widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: 'Calendar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'School',
                ),
              ],
              selectedItemColor: Colors.blue[90],
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            )
        )
    );
  }
}
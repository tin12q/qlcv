import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:qlcv/model/task.dart';
import 'package:qlcv/model/task_box.dart';
import 'package:qlcv/model/color_picker.dart';

import '../model/db_helper.dart';
import 'task_create.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                Container(
                  height: 60,
                  child: Row(
                    //right to left
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DBHelper.mainUser.name,
                        style: const TextStyle(
                          color: ColorPicker.fontDark,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 60),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300, // Adjust the width as needed
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0), // Adjust the border radius as needed
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          DBHelper.tasks = DBHelper.resTasks
                              .where((task) => task.title
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: TaskBoxList(tasks: DBHelper.tasks),
                )
              ],
            )));
  }
}

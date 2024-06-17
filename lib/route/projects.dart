import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:qlcv/model/task_box.dart';
import 'package:qlcv/model/color_picker.dart';
import 'package:qlcv/route/project_create.dart';

import '../model/db_helper.dart';
import '../model/project_box.dart';
import 'task_create.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key}) : super(key: key);
  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
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


                       DBHelper.mainUser.role == 'admin' ? SafeArea(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectCreateRoute(),
                              ),
                            );
                          },
                          child: const CircleAvatar(
                            backgroundColor: ColorPicker.accent,
                            //size
                            radius: 20,
                            child: Icon(
                              Icons.add,
                              color: ColorPicker.primary,
                            ),
                          ),
                        ),
                      ) : SafeArea(
                         child: InkWell(
                           onTap: () {
                             showDialog(
                               context: context,
                               builder: (BuildContext context) {
                                 return AlertDialog(
                                   title: const Text('Warning'),
                                   content: const Text('You are not allowed to delete tasks'),

                                 );
                               },
                             );
                           },
                           child: const CircleAvatar(
                             backgroundColor: ColorPicker.accent,
                             //size
                             radius: 20,
                             child: Icon(
                               Icons.add,
                               color: ColorPicker.primary,
                             ),
                           ),
                         ),
                       ),
                      const SizedBox(width: 30),
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

                          DBHelper.projects = DBHelper.resProjects
                              .where((project) => project.title
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: projectBoxList(projects: DBHelper.projects),
                )
              ],
            )));
  }
}

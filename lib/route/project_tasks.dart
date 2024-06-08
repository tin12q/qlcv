import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:qlcv/model/task.dart';
import 'package:qlcv/model/task_box.dart';
import 'package:qlcv/model/color_picker.dart';

import '../model/db_helper.dart';
import 'task_create.dart';

class ProjectTasks extends StatefulWidget {
  const ProjectTasks({Key? key}) : super(key: key);
  @override
  State<ProjectTasks> createState() => _ProjectTasksState();
}

class _ProjectTasksState extends State<ProjectTasks> {
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
                      SafeArea(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskCreateRoute(),
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
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                ),
                Expanded(
                  child: TaskBoxList(tasks: DBHelper.projectTasks),
                )
              ],
            )));
  }
}

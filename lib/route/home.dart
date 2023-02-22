import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:qlcv/model/task.dart';
import 'package:qlcv/model/task_box.dart';
import 'package:qlcv/model/color_picker.dart';

import '../model/db_helper.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              SafeArea(
                child:  InkWell(
                    onTap: () {
                      print('tap');
                    },
                    child: const CircleAvatar(
                      backgroundColor: ColorPicker.accent,
                      //size
                      radius: 25,
                      child: Icon(
                        Icons.add,
                        color: ColorPicker.primary,
                      ),
                    ),
                  ),

              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
        Expanded(
          child: TaskBoxList(tasks: DBHelper.tasks),
        )
      ],
    )));
  }
}

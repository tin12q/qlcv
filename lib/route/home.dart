import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:qlcv/model/task.dart';
import 'package:qlcv/model/task_box.dart';
import 'package:qlcv/model/color_picker.dart';

import '../model/data_proc.dart';

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
                child: Container(
                  child: InkWell(
                    onTap: () {
                      print('tap');
                    },
                    child: CircleAvatar(
                      child: Icon(
                        Icons.add,
                        color: ColorPicker.primary,
                      ),
                      backgroundColor: ColorPicker.accent,
                      //size
                      radius: 25,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
        Expanded(
          child: TaskBoxList(tasks: DataProc.tasks),
        )
      ],
    )));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
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
              const Text(
               'a',
                style: TextStyle(
                  color: ColorPicker.fontDark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 60),
              SafeArea(
                child:  InkWell(
                    onTap: () {
                      print('tap');
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
          child: TaskBoxList(tasks: DBHelper.tasks),
        )
      ],
    )));
  }
}

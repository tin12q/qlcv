import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qlcv/model/color_picker.dart';
import 'package:qlcv/model/dep.dart';

import '../model/db_helper.dart';
import 'package:intl/intl.dart';
import 'package:qlcv/model/task.dart';

class TaskCreateRoute extends StatefulWidget {
  @override
  State<TaskCreateRoute> createState() => _TaskCreateRouteState();
}

class _TaskCreateRouteState extends State<TaskCreateRoute> {
  //text controller
  TextEditingController dateinput = TextEditingController();
  String depName = "";
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  //TODO: create controller for each text field
  @override
  Widget build(BuildContext context) {
    // TODO: page to create a new task
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
        backgroundColor: ColorPicker.accent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Title',
                    style: TextStyle(
                      color: ColorPicker.fontDark,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter title',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    //create a dropdown button  from the list of departments from DBHelper.deps
                    child: DropdownButtonFormField<Dep>(
                      decoration: const InputDecoration(
                        labelText: 'Department',
                      ),
                      items: DBHelper.deps
                          .map(
                            (dep) => DropdownMenuItem<Dep>(
                              value: dep,
                              child: Text(dep.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        //TODO: set the value of the department
                        setState(() {
                          depName = value!.name;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: dateinput, //editing controller of this TextField
                decoration: InputDecoration(
                  icon: Icon((Platform.isIOS)
                      ? CupertinoIcons.calendar_badge_plus
                      : Icons.calendar_month), //icon of text field
                  labelText: "End Date", //label text of field
                ),
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      builder: (context, child) => Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                                primary: ColorPicker.accent,
                              ),
                            ),
                            child: child!,
                          ),
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2023), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2025));

                  if (pickedDate != null) {
                    //print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    //print(formattedDate);

                    setState(() {
                      dateinput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter description',
                ),
                maxLines: null,
              )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: _back,
                      child: Text('Cancel'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorPicker.accent),
                      )),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: null,
                      child: Text('Create'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorPicker.accent),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _back() {
    Navigator.pop(context);
  }

  void _createTask() async {
    try {} catch (e) {
      print(e);
    }
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qlcv/model/color_picker.dart';
import 'package:qlcv/model/dep.dart';

import '../home_page.dart';
import '../main.dart';
import '../model/db_helper.dart';
import 'package:intl/intl.dart';
import 'package:qlcv/model/task.dart';

import '../model/emp.dart';
import 'home.dart';

class TaskCreateRoute extends StatefulWidget {
  @override
  State<TaskCreateRoute> createState() => _TaskCreateRouteState();
}

class _TaskCreateRouteState extends State<TaskCreateRoute> {
  //text controller
  TextEditingController dateinput = TextEditingController();
  TextEditingController titleinput = TextEditingController();
  TextEditingController descinput = TextEditingController();
  Set<Employee> selectedEmployees = {};
  List<String> employees = [];
  DateTime end = DateTime.now();
  String empName = "";
  @override


  void initState() {
    dateinput.text = "";
    for(var emp in DBHelper.empProject){
      for(var employee in DBHelper.employees){
        if(emp == employee.id){
          employees.add(employee.name);
        }
      }
    }
    empName = ""; //set the initial value of text field
    super.initState();
    isPaused = true;
  }


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
                      controller: titleinput,
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
                    child: DropdownButtonFormField<Employee>(
                      decoration: const InputDecoration(
                        labelText: 'Employee',
                      ),
                      items: DBHelper.employees.map(
                            (employee) => DropdownMenuItem<Employee>(
                          value: employee,
                          child: Text(employee.name),
                        ),
                      ).toList(),
                      onChanged: (Employee? value) {
                        setState(() {
                          selectedEmployees.clear();
                          if (value != null) {
                            selectedEmployees.add(value);
                          }
                          empName = value!.name;
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
                              colorScheme: const ColorScheme.light(
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
                      dateinput.text = formattedDate;
                      end = pickedDate;
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: TextField(
                controller: descinput,
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
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorPicker.accent),
                      ),
                      child: const Text('Cancel')),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: _createTask,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorPicker.accent),
                      ),
                      child: const Text('Create')),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _back() {
    Navigator.pop(context);
  }
  @override
  void dispose() {
    isPaused = false;
    super.dispose();
  }
  void _createTask() async {
    try {
      if (titleinput.text == "" ||
          empName == "" ||
          dateinput.text == "" ||
          descinput.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all the fields',
                style: TextStyle(color: ColorPicker.primary)),
            backgroundColor: ColorPicker.accent,
            duration: Duration(seconds: 2),
          ),
        );
        throw Exception("Please fill all the fields");
      }
      var empId = DBHelper.employees.firstWhere((element) => element.name == empName).id;
      Task task = new Task(
          title: titleinput.text,
          description: descinput.text,
          status: 'in_progress',
          project: DBHelper.currentProjectId,
          endDate: end,
          emp: [empId]);
      //
      await DBHelper.addTask(task);
      DBHelper.tasks.add(task);
      DBHelper.projectTasks.add(task);
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}

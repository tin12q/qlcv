import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qlcv/main.dart';
import 'package:qlcv/model/db_helper.dart';
import 'package:qlcv/route/project_tasks.dart';
import '../home_page.dart';
import '../route/home.dart';
import 'color_picker.dart';
import 'task.dart';
import 'db_helper.dart';

class TaskPage extends StatefulWidget {
  final Task task;

  const TaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  State<TaskPage> createState() => _TaskPageState(task: task);
}

class _TaskPageState extends State<TaskPage> {
  late Task task;

  Future<void> updateTask(Task task, String title, String description, DateTime endDate, String status) async {
    DateFormat outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

    task.title = title;
    task.description = description;
    // task.startDate = startDate;
    task.endDate = endDate;
    task.status = status;

    await DBHelper.updateTask(task);
    DBHelper.tasks.clear();
    DBHelper.projectTasks.clear();
    await DBHelper.taskUpdate();
  }

  _TaskPageState({required this.task});

  @override
  Widget build(BuildContext context) {
    // Create TextEditingController for each field

    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);
    final statusController = TextEditingController(text: task.status);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        backgroundColor: ColorPicker.accent,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DBHelper.mainUser.role == 'admin' ? Container(
                height: 25,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPicker.primary,
                    foregroundColor: ColorPicker.accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text('Update Task'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Warning'),
                          content: const Text(
                              'Are you sure you want to update this task?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Closes the dialog
                              },
                            ),
                            TextButton(
                              child: const Text('Confirm'),
                              onPressed: () {
                                updateTask(task, titleController.text, descriptionController.text, task.endDate, statusController.text);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
                                      (Route<dynamic> route) => false,
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ) : Container(),
              const SizedBox(height: 16.0),
              TextField(
                controller: titleController,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: descriptionController,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              // TextField(
              //   readOnly: true,
              //   controller: TextEditingController(text: DateFormat('d/M/yyyy').format(task.startDate)),
              //   onTap: () async {
              //     final selectedDate = await showDatePicker(
              //       context: context,
              //       initialDate: task.startDate,
              //       firstDate: DateTime(2000),
              //       lastDate: DateTime.now(),
              //     );
              //     if (selectedDate != null) {
              //       setState(() {
              //         task.startDate = selectedDate;
              //       });
              //     }
              //   },
              //   style: const TextStyle(fontSize: 16.0),
              // ),
              const SizedBox(height: 16.0),
              TextField(
                readOnly: true,
                controller: TextEditingController(text: DateFormat('d/M/yyyy').format(task.endDate)),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: task.endDate.isAfter(DateTime.now()) ? DateTime.now() : task.endDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(3000), // set this to a future date
                  );
                  if (selectedDate != null) {
                    setState(() {
                      task.endDate = selectedDate;
                    });
                  }
                },
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: statusController,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Assigned Employees',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: task.empWidget,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:qlcv/main.dart';
import 'package:qlcv/model/db_helper.dart';
import 'package:qlcv/model/project.dart';
import 'package:qlcv/model/task_page.dart';
import 'package:qlcv/route/home.dart';
import 'package:qlcv/route/project_tasks.dart';
import '../home_page.dart';
import 'color_picker.dart';
import 'project.dart';
import 'db_helper.dart';

class ProjectPage extends StatefulWidget {
  final Project project;

  const ProjectPage({
    Key? key,
    required this.project,
  }) : super(key: key);

  State<ProjectPage> createState() => _ProjectPageState(project: project);
}

class _ProjectPageState extends State<ProjectPage> {
  late Project project;

  Future<void> updateProject(Project project, String title, String description, DateTime endDate, String status) async {
    DateFormat outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

    project.title = title;
    project.description = description;
    project.endDate = endDate;
    project.status = status;

    await DBHelper.updateProject(project);
    DBHelper.projects.clear();
    // await DBHelper.projectUpdate();
  }

  _ProjectPageState({required this.project});

  @override
  Widget build(BuildContext context) {
    // Create TextEditingController for each field
    final titleController = TextEditingController(text: project.title);
    final descriptionController = TextEditingController(text: project.description);
    final statusController = TextEditingController(text: project.status);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DBHelper.mainUser.role == 'admin' ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPicker.primary,
                      foregroundColor: ColorPicker.accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Update Project'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Warning'),
                            content: const Text(
                                'Are you sure you want to update this project?'),
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
                                  updateProject(project, titleController.text, descriptionController.text, project.endDate, statusController.text);
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
                  ) : Container(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPicker.primary,
                      foregroundColor: ColorPicker.accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Tasks Details'),
                    onPressed: () async {
                      await DBHelper.taskUpdateWithProjectId(project.id);
                      await DBHelper.getEmpByProjectId(DBHelper.currentProjectId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectTasks(),
                        ),
                      );
                    },
                  ),
                ],
              ),
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
              TextField(
                readOnly: true,
                controller: TextEditingController(text: DateFormat('d/M/yyyy').format(project.endDate)),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: project.endDate.isAfter(DateTime.now()) ? DateTime.now() : project.endDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(3000), // set this to a future date
                  );
                  if (selectedDate != null) {
                    setState(() {
                      project.endDate = selectedDate;
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
                'Assigned Team',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                DBHelper.currentDepName,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
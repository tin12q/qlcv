import 'package:flutter/material.dart';
import 'package:qlcv/model/db_helper.dart';

import 'package:qlcv/model/projects_page.dart';
import '../home_page.dart';
import '../route/home.dart';
import 'color_picker.dart';
import 'project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({required this.project});
  Future<void> deleteproject(Project project) async {
    await DBHelper.deleteProject(project);
    DBHelper.projects.clear();
    // await DBHelper.projectUpdate();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: ColorPicker.accent,
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListTile(
          title: Text(project.title,
              style: const TextStyle(
                color: ColorPicker.primary,
                //bold
                fontWeight: FontWeight.bold,
                fontSize: 30,
              )),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                  (project.description.length > 15)
                      ? project.description.substring(0, 15) + '...'
                      : project.description,
                  style: const TextStyle(
                    color: ColorPicker.primary,
                    fontSize: 17,
                  )),
              const SizedBox(height: 10),
              Text(project.status,
                  style: const TextStyle(
                    color: ColorPicker.primary,
                    fontSize: 25,
                  )),
              Text(project.endDateString,
                  style: const TextStyle(
                    color: ColorPicker.primary,
                    //bold
                    //fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
              //const SizedBox(height: 10),
            ],
          ),
          trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 0),
                Container(
                  height: 25,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPicker.primary,
                      foregroundColor: ColorPicker.accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('Info'),
                    onPressed: () async {
                      await DBHelper.getDepNameById(project.dep);
                      DBHelper.currentProjectId = project.id;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectPage(
                                project: project,
                              )));
                    },
                  ),
                ),
                const SizedBox(height: 6),
                DBHelper.mainUser.role == 'admin' ? Container(
                    height: 25,
                    child:   ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPicker.dark,
                        foregroundColor: ColorPicker.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Icon(Icons.delete_outline, color: ColorPicker.primary,),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Warning'),
                              content: const Text('Are you sure you want to delete this project?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('No'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Closes the dialog
                                  },
                                ),
                                TextButton(
                                  child: const Text('Confirm'),
                                  onPressed: () {
                                    deleteproject(project); // Calls the deleteproject function
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
                    )
                ) : Container(
                    height: 25,
                    child:   ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPicker.dark,
                        foregroundColor: ColorPicker.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('Delete'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Warning'),
                              content: const Text('You are not allowed to delete projects'),

                            );
                          },
                        );
                      },
                    )
                )
              ]),
          onTap: () {
            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => projectPage(
                          project: project,
                        )
                ));*/
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return projectPopupCard(project: project);
                });
          },
        ),
      ),
    );
  }


}

class projectBoxList extends StatelessWidget {
  final List<Project> projects;

  const projectBoxList({
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        if (index >= 0 && index < projects.length) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: ProjectCard(project: projects[index]),
              ),
              const SizedBox(width: 10)
            ],
          );
        } else {
          print('Index $index is out of range for list of length ${projects.length}');
          return Row(); // Return an empty Row or some other widget
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 15);
      },
    );
  }
}

class projectPopupCard extends StatelessWidget {
  final Project project;

  const projectPopupCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10,
      backgroundColor: ColorPicker.accent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: const TextStyle(
                color: ColorPicker.primary,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Status: ${project.status}',
              style: const TextStyle(
                color: ColorPicker.primary,
                //bold
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              project.description,
              style: const TextStyle(
                color: ColorPicker.primary,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Department: ${DBHelper.currentDepName}',
              style: const TextStyle(
                color: ColorPicker.primary,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 10.0),

            const SizedBox(height: 10.0),
            Text(
              'End Date: ${project.endDateString}',
              style: const TextStyle(
                color: ColorPicker.primary,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

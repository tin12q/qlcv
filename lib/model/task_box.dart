import 'package:flutter/material.dart';
import 'package:qlcv/model/db_helper.dart';
import 'package:qlcv/model/task_page.dart';
import '../home_page.dart';
import '../route/home.dart';
import 'color_picker.dart';
import 'task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({required this.task});
  Future<void> deleteTask(Task task) async {
    await DBHelper.deleteTask(task);
    DBHelper.tasks.clear();
    await DBHelper.taskUpdate();

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
          title: Text(task.title,
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
                  (task.description.length > 15)
                      ? task.description.substring(0, 15) + '...'
                      : task.description,
                  style: const TextStyle(
                    color: ColorPicker.primary,
                    fontSize: 17,
                  )),
              const SizedBox(height: 10),
              Text(task.status,
                  style: const TextStyle(
                    color: ColorPicker.primary,
                    fontSize: 25,
                  )),
              Text(task.endDateString,
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TaskPage(
                                      task: task,
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
                              content: const Text('Are you sure you want to delete this task?'),
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
                                    deleteTask(task); // Calls the deleteTask function
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
                              content: const Text('You are not allowed to delete tasks'),

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
                    builder: (context) => TaskPage(
                          task: task,
                        )
                ));*/
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return TaskPopupCard(task: task);
                });
          },
        ),
      ),
    );
  }


}

class TaskBoxList extends StatelessWidget {
  final List<Task> tasks;

  const TaskBoxList({
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        if (index >= 0 && index < tasks.length) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: TaskCard(task: tasks[index]),
              ),
              const SizedBox(width: 10)
            ],
          );
        } else {
          print('Index $index is out of range for list of length ${tasks.length}');
          return Row(); // Return an empty Row or some other widget
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 15);
      },
    );
  }
}

class TaskPopupCard extends StatelessWidget {
  final Task task;

  const TaskPopupCard({required this.task});

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
              task.title,
              style: const TextStyle(
                color: ColorPicker.primary,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Status: ${task.status}',
              style: const TextStyle(
                color: ColorPicker.primary,
                //bold
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              task.description,
              style: const TextStyle(
                color: ColorPicker.primary,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 10.0),
            // Text(
            //   'Department: ${task.dep}',
            //   style: const TextStyle(
            //     color: ColorPicker.primary,
            //     fontSize: 20.0,
            //   ),
            // ),
            // const SizedBox(height: 10.0),
            // Text(
            //   'Start Date: ${task.startDateString}',
            //   style: const TextStyle(
            //     color: ColorPicker.primary,
            //     fontSize: 20.0,
            //   ),
            // ),
            const SizedBox(height: 10.0),
            Text(
              'End Date: ${task.endDateString}',
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

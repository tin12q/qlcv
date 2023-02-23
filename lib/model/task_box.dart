import 'package:flutter/material.dart';
import 'package:qlcv/model/task_page.dart';
import 'color_picker.dart';
import 'task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({required this.task});

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
                    fontSize: 20,
                  )),
              const SizedBox(height: 10),
              Text(task.endDateString,
                  style: const TextStyle(
                    color: ColorPicker.primary,
                    //bold
                    //fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )),
              //const SizedBox(height: 10),
            ],
          ),

          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.status,
              style: const TextStyle(
                color: ColorPicker.primary,
                fontSize: 20,
              )),
                SizedBox(height: 2),
                Container(
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ColorPicker.primary,
                      onPrimary: ColorPicker.accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Info'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskPage(
                                    task: task,
                                  )));
                    },
                  )
                ),

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
      itemBuilder: (context, index) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 10),
          Expanded(
            child: TaskCard(task: tasks[index]),
          ),
          SizedBox(width: 10)
        ],
      ),
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 15);
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
                Text(
                  'Department: ${task.dep}',
                  style: const TextStyle(
                    color: ColorPicker.primary,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Start Date: ${task.startDateString}',
                  style: const TextStyle(
                    color: ColorPicker.primary,
                    fontSize: 20.0,
                  ),
                ),
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


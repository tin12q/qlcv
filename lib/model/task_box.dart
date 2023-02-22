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
              Text(task.endDate.toString(),
                  style: const TextStyle(
                    color: ColorPicker.primary,
                    fontSize: 13,
                  )),
              //const SizedBox(height: 10),
            ],
          ),
          trailing: Text(task.status,
              style: const TextStyle(
                color: ColorPicker.primary,
                fontSize: 20,
              )),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskPage(
                          task: task,
                        )));
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

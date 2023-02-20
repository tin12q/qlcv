import 'package:flutter/material.dart';
import 'task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.blue[90],
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListTile(

          title: Text(task.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.description),
              Text(task.date.toString()),
            ],
          ),

          trailing: Text(task.status),
          onTap: () {
            print('Tapped on ${task.title}');
          },
        ),
      ),
    );
  }
}
class TaskBoxList extends StatelessWidget {
  final List<Task> tasks;

  TaskBoxList({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return
          /*Flexible(
          child: TaskCard(task: tasks[index]),
        );*/
        TaskCard(task: tasks[index]);
      },
    );
  }
}
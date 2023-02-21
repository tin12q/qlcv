import 'package:flutter/material.dart';
import 'package:qlcv/model/task_page.dart';
import 'color_picker.dart';
import 'task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: ColorPicker.primaryDark,
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(7.0),
        child: ListTile(

          title: Text(
              task.title,
            style: TextStyle(
              color: ColorPicker.primaryLight,
              fontSize: 30,
            )),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((task.description.length>15)?
              task.description.substring(0,15)+'...':task.description,
                style: TextStyle(
                  color: ColorPicker.primaryLight,
                  fontSize: 15,
                )),
              Text(task.date.toString(),
                style: TextStyle(
                  color: ColorPicker.primaryLight,
                  fontSize: 20,
                )),
            ],
          ),

          trailing: Text(task.status,
            style: TextStyle(
              color: ColorPicker.primaryLight,
              fontSize: 20,
            )),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage(task: task,)));
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

      ), separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 15);
    },

    );
  }
}
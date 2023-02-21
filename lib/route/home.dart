import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qlcv/model/task.dart';
import 'package:qlcv/model/task_box.dart';
class Home extends StatefulWidget{
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home>{
  List<Task> task = [
    Task(title: 'Task 1', description: ''
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', status: 'Status 1', date: DateTime.now()),
    Task(title: 'Task 2', description: 'Description 2', status: 'Status 2', date: DateTime.now()),
    Task(title: 'Task 3', description: 'Description 3', status: 'Status 3', date: DateTime.now())
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
      Scaffold(
        body:
        Column(
          children: [
            Container(
              height: 50,
              child: Row(
                //right to left
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      child: CircleAvatar(
                        child: Icon(Icons.add),
                      ),
                    ),
                    )],
              ),
            ),
            Expanded(
              child: TaskBoxList(tasks: task),
            )
          ],
        )
        )
    );

  }
}
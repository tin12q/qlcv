import 'package:flutter/material.dart';
import 'package:qlcv/main.dart';
import 'task.dart';

class TaskPage extends StatefulWidget{
  final Task task;
  const TaskPage({required this.task});
  @override
  State<TaskPage> createState() => _TaskPageState();
}
class _TaskPageState extends State<TaskPage>{
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body:SafeArea(child: Column(
        children: [

          Text(widget.task.title),
          Text(widget.task.description),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
            },
            child: Text('Back'),
          )
        ]
      ),
    )
    );
  }
}
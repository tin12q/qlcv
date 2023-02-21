import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Calendar extends StatefulWidget{
  @override
  State<Calendar> createState() => _CalendarState();
}
class _CalendarState extends State<Calendar>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
      Scaffold(
        body: Center(
        child: Text('Calendar'),
      ),
    )
    );
  }
}
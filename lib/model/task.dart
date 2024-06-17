//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'db_helper.dart';

class Task {
  String _id = '';
  String _title = '';
  String _description = '';
  String _status = '';
  String _project = '';
  DateTime _endDate = DateTime.now();
  List<String> _emp = [];

  get id => _id;
  get title => _title;
  get description => _description;
  get status => _status;
  get endDate => _endDate;
  get project => _project;
  get endDateString =>
      '${_endDate.day.toString()}/${_endDate.month.toString()}/${_endDate.year.toString()}';
  get emp => _emp;
  get empWidget {
    List<Widget> empWidget = [];
    for (var empId in _emp) {
      var emp = DBHelper.empMap[empId]; // Get the employee object from empMap
      if (emp != null) {
        empWidget.add(Text(emp.name)); // Use the employee name
      }
    }
    return empWidget;
  }

  set id(id) => _id = id;
  set title(title) => _title = title;
  set description(description) => _description = description;
  set status(status) => _status = status;
  set endDate(edate) => _endDate = edate;
  set emp(emp) => _emp = emp;
  set project(project) => _project = project;
  Task(
      { String? id,
        required String title,
      required String description,
      required String status,
        required String project,
      required DateTime endDate,
      required List<String> emp}) {
    if(id != null) _id = id;
    _title = title;
    _description = description;
    _project = project;
    _status = status;
    _endDate = endDate;
    _emp = emp;
  }

  @override
  String toString() {
    return 'task{_title: $_title, _description: $_description, _status: $_status, _startDate: _endDate: $_endDate}, _emp: $_emp}';
  }
}

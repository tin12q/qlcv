//import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String _title = '';
  String _description = '';
  String _status = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  get title => _title;
  get description => _description;
  get status => _status;
  get startDate => _startDate;
  get endDate => _endDate;
  set title(title) => _title = title;
  set description(description) => _description = description;
  set status(status) => _status = status;
  set startDate(sdate) => _startDate = sdate;
  set endDate(edate) => _endDate = edate;

  Task(
      {required String title,
      required String description,
      required String status,
      required DateTime startDate,
      required DateTime endDate}) {
    _title = title;
    _description = description;
    _status = status;
    _startDate = startDate;
    _endDate = endDate;
  }

  @override
  String toString() {
    return 'task{_title: $_title, _description: $_description, _status: $_status, _startDate: $_startDate, _endDate: $_endDate}';
  }
}

class Task{
  String _title='';
  String _description='';
  String _status='';
  DateTime _date=DateTime.now();

  get title => _title ;
  get description => _description;
  get status => _status;
  get date => _date;
  set title(title) => _title = title;
  set description(description) => _description = description;
  set status(status) => _status = status;
  set date(date) => _date = date;

  Task({required String title, required String description, required String status, required DateTime date}){
    _title = title;
    _description = description;
    _status = status;
    _date = date;
  }

  @override
  String toString() {
    return 'task{_title: $_title, _description: $_description, _status: $_status, _date: $_date}';
  }

}
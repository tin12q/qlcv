class Project{
  String _id = '';
  String _title = '';
  String _description = '';
  String _status = '';
  String _dep = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  List<String> _taskID = [];

  Project(
      {String? id,
      required String title,
      required String description,
      required String status,
      required String dep,
      required DateTime startDate,
      required DateTime endDate,
      required List<String> taskID}) {
    if(id != null) _id = id;
    _title = title;
    _description = description;
    _status = status;
    _dep = dep;
    _startDate = startDate;
    _endDate = endDate;
    _taskID = taskID;
  }

  get id => _id;
  get title => _title;
  get description => _description;
  get status => _status;
  get dep => _dep;
  get startDate => _startDate;
  get endDate => _endDate;
  get startDateString =>
      '${_startDate.day.toString()}/${_startDate.month.toString()}/${_startDate.year.toString()}';
  get endDateString =>
      '${_endDate.day.toString()}/${_endDate.month.toString()}/${_endDate.year.toString()}';
  get taskID => _taskID;


  set id(id) => _id = id;
  set title(title) => _title = title;
  set description(description) => _description = description;
  set status(status) => _status = status;
  set dep(dep) => _dep = dep;
  set startDate(sdate) => _startDate = sdate;
  set endDate(edate) => _endDate = edate;
  set taskID(taskID) => _taskID = taskID;


  @override
  String toString() {
    return 'Project{id: $_id, title: $_title, description: $_description, status: $_status, dep: $_dep, startDate: $_startDate, endDate: $_endDate, taskID: $_taskID}';
  }
}
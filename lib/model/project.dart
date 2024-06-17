class Project{
  String _id = '';
  String _title = '';
  String _description = '';
  String _status = '';
  String _dep = '';
  DateTime _endDate = DateTime.now();

  Project(
      {String? id,
      required String title,
      required String description,
      required String status,
      required String dep,
      required DateTime endDate,
      }) {
    if(id != null) _id = id;
    _title = title;
    _description = description;
    _status = status;
    _dep = dep;
    _endDate = endDate;
  }

  get id => _id;
  get title => _title;
  get description => _description;
  get status => _status;
  get dep => _dep;
  get endDate => _endDate;

  get endDateString =>
      '${_endDate.day.toString()}/${_endDate.month.toString()}/${_endDate.year.toString()}';


  set id(id) => _id = id;
  set title(title) => _title = title;
  set description(description) => _description = description;
  set status(status) => _status = status;
  set dep(dep) => _dep = dep;
  set endDate(edate) => _endDate = edate;


  @override
  String toString() {
    return 'Project{id: $_id, title: $_title, description: $_description, status: $_status, dep: $_dep, endDate: $_endDate}';
  }
}
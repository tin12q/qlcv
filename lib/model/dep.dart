class Dep {
  String _id = '';
  String _name = '';
  List<String> _emp = [];
  get name => _name;
  get emp => _emp;
  get id => _id;
  set name(name) => _name = name;
  set emp(emp) => _emp = emp;
  set id(id) => _id = id;

  Dep({required id, required name, required emp}) {
    _id = id;
    _name = name;
    _emp = emp;
  }
}

class Dep {
  String _name = '';
  List<String> _emp = [];
  get name => _name;
  get emp => _emp;
  set name(name) => _name = name;
  set emp(emp) => _emp = emp;

  Dep({required name, required emp}) {
    _name = name;
    _emp = emp;
  }
}

class Employee {

  String _name = '';
  String _role = '';
  String _id = '';
  String _ava= '';
  Employee(
      {required name,
      required role,
      required id,
      ava = ''}) {
    _name = name;
    _role = role;
    _id = id;
    _ava = ava;
  }
  get name => _name;
  get role => _role;
  get id => _id;
  get ava => _ava;
  set setName(String name) => _name = name;
  set setRole(String role) => _role = role;
  set setId(String id) => _id = id;
  set setAva(String ava) => _ava = ava;
}

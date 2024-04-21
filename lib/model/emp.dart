class Employee {
  String _name = '';
  String _email = '';
  String _dep = '';
  String _role = '';
  String _id = '';
  String _ava= '';
  Employee(
      {required name,
      required email,
      required dep,
      required role,
      required id,
      ava = ''}) {
    _name = name;
    _email = email;
    _dep = dep;
    _role = role;
    _id = id;
    _ava = ava;
  }
  get name => _name;
  get email => _email;
  get dep => _dep;
  get role => _role;
  get id => _id;
  get ava => _ava;
  set setName(String name) => _name = name;
  set setEmail(String email) => _email = email;
  set setDep(String dep) => _dep = dep;
  set setRole(String role) => _role = role;
  set setId(String id) => _id = id;
  set setAva(String ava) => _ava = ava;
}

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:qlcv/model/dep.dart';
import 'package:qlcv/model/task.dart';
import 'package:qlcv/model/project.dart';
import 'emp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DBHelper {
  static var client = http.Client();
  static List<Task> tasks = [];
  static String token = '';
  static Employee mainUser =
  Employee(name: '', email: '', dep: '', role: '', id: '');
  static List<Project> projects = [];
  static List<Task> projectTasks = [];
  static List<Employee> employees = [];
  static List<Dep> deps = [];
  static var empMap = {};
  static var depMap = {};
  static String currentDepName = '';
  static String currentProjectId = '';
  static Future<void> getProject() async {
    try{
      var url = Uri.parse('http://10.0.2.2:1337/api/projects/all');
      var response = await http.get(
          url,
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
      );
      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var project in data) {
          projects.add(Project(
            id: project['_id'],
            title: project['title'] ?? 'default_value',
            description: project['description'] ?? 'default_value',
            status: project['status'] ?? 'default_value',
            startDate: DateTime.parse(project['start_date'].toString()),
            endDate: DateTime.parse(project['due_date'].toString()),
            dep: project['team'] ?? 'default_value',
            taskID: List<String>.from(project['task']) ?? [],
          ));
        }

      } else {
        throw Exception('Failed to get projects.');
      }
    } catch (e) {
      print(e);
    }
  }
  static Future<void> getEmp() async {
    try {
      var url = Uri.parse('http://10.0.2.2:1337/api/users/getAll');
      var response = await http.get(
        url,
        headers: <String, String>{

          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var emp in data) {
          employees.add(Employee(
              name: emp['name'],
              email: emp['email'],
              dep: emp['team'],
              role: emp['role'],
              id: emp['_id']));
        }
      } else {
        throw Exception('Failed to get employees.');
      }
    } catch (e) {
      print(e);
    }

  }

  static Future<void> getDep() async {
    deps.clear();
    try {
      var url = Uri.parse('http://10.0.2.2:1337/api/teams/');
      var response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var dep in data) {
          List<String> members = List<String>.from(dep['members']);
          //if dep['name'] is already in deps, continue
          deps.add(Dep(name: dep['name'], emp: members));
        }
      } else {
        throw Exception('Failed to get departments.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> updateDep() async {
    try{
      var url = Uri.parse('http://10.0.2.2:1337/api/teams/');
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var dep in data) {
          depMap[dep['name']] = dep['members'];
        }
      } else {
        throw Exception('Failed to update departments.');
      }
    } catch (e) {
        print(e);
    }
  }
  static Future<void> getDepName(String id) async {
    try {
      var url = Uri.parse('http://10.0.2.2:1337/api/teams/$id');
      var response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        currentDepName = data['name'];

      } else {
        throw Exception('Failed to get team name.');
      }
    }
    catch (e) {
      print(e);
      throw Exception('Failed to get team name.');
    }
  }
  static Future<void> getMainUser({required String id}) async {
    try {
      var url = Uri.parse('http://10.0.2.2:1337/api/users/$id');
      var response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        mainUser = Employee(
            name: data['name'],
            email: data['email'],
            dep: data['team'],
            role: data['role'],
            id: data['_id'],
            ava: data['ava']);
      } else {
        throw Exception('Failed to get main user.');
      }
    } catch (e) {
      print(e);
    }
  }
  static Future<void> deleteTask(Task task) async {
    try{
      var url = Uri.parse('http://10.0.2.2:1337/api/tasks/${task.id}');
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200) {
        tasks.clear();
        print('Task deleted');
      } else {
        throw Exception('Failed to delete task.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> addProject(Project project) async {
    try {
      var url = Uri.parse('http://10.0.2.2:1337/api/projects');

      var response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer $token',
          },
          body: <String, String>{
            'title': project.title,
            'description': project.description,
            'status': 'In Progress',
            'team': project.dep,
            'start_date': project.startDate.toString(),
            'due_date': project.endDate.toString(),
            'task': project.taskID.join(','), // Convert List<String> to String
          }
      );
      if(response.statusCode == 201) {
        print('Project added');
      } else {
        throw Exception('Failed to add project.');
      }

    }
    catch (e) {
      print(e);
    }
  }
  static Future<void> deleteProject(Project project) async {
    try {
      var url = Uri.parse('http://10.0.2.2:1337/api/projects/${project.id}');
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        projects.clear();
        print('Project deleted');
      } else {
        throw Exception('Failed to delete project.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> updateProject(Project project) async {
    try {
      var url = Uri.parse('http://10.0.2.2:1337/api/projects/${project.id}');
      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token',
        },
        body: <String, String>{
          'title': project.title,
          'description': project.description,
          'status': project.status,
          'start_date': project.startDate.toString(),
          'due_date': project.endDate.toString(),
        },
      );
      if(response.statusCode == 200) {
        projects.clear();
        print('Project updated');
      } else {
        throw Exception('Failed to update project.');
      }
    } catch (e) {
      print(e);
    }
  }
  static Future<void> taskUpdate() async {
    tasks.clear();
    projectTasks.clear();
    try {
      var url = Uri.parse('http://10.0.2.2:1337/api/tasks/getAll');
      var response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var task in data) {
          List<String> members = (task['emp'] as List<dynamic>).map((item) => item.toString()).toList();
          if(mainUser.role == 'Admin') {
            tasks.add(Task(
                id: task['_id'],
                title: task['title'],
                description: task['description'],
                status: task['status'],
                dep: task['team'],
                startDate: DateTime.parse(task['startDate']),
                endDate: DateTime.parse(task['endDate']),
                emp: members));
          } else {
            if(members.contains(mainUser.id)) {
              tasks.add(Task(
                  id: task['_id'],
                  title: task['title'],
                  description: task['description'],
                  status: task['status'],
                  dep: task['team'],
                  startDate: DateTime.parse(task['startDate']),
                  endDate: DateTime.parse(task['endDate']),
                  emp: members));
            }
          }
        }

      } else {
        throw Exception('Failed to update tasks.');
      }

    } catch (e) {
      print(e);
    }
  }
  static Future<void> projectUpdate() async {
    projects.clear();
    try {
      var url = Uri.parse('http://10.0.2.2:1337/api/projects/all');
      var response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var project in data) {
          projects.add(Project(
            id: project['_id'],
            title: project['title'] ?? 'default_value',
            description: project['description'] ?? 'default_value',
            status: project['status'] ?? 'default_value',
            startDate: DateTime.parse(project['start_date'].toString()),
            endDate: DateTime.parse(project['due_date'].toString()),
            dep: project['team'] ?? 'default_value',
            taskID: List<String>.from(project['task']) ?? [],
          ));
        }
      } else {
        throw Exception('Failed to get projects.');
      }
    } catch (e) {
      print(e);
    }
  }
  static taskUpdateWithProjectId(String projectId)  {
      projectTasks.clear();
      for(Project project in projects) {
        if(project.id == projectId) {
          for(String taskId in project.taskID) {
            for(Task task in tasks) {
              if(task.id == taskId) {
                projectTasks.add(task);
              }
            }
          }
        }
      }
      print(projectTasks);
  }


  static Future<void> logIn({required String email, required String password}) async {
    try{
      var url = Uri.parse('http://10.0.2.2:1337/api/auth/login');
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        token = response.headers['authorization']!.split(" ")[1];
        await getMainUser(id: data['id']);
      } else {
        throw Exception('Failed to login.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> updateAvater(File file) async {
    try {
      var url = Uri.parse('http://10.0.2.2:1337/api/file/upload');
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Avatar uploaded');
      } else {
        throw Exception('Failed to upload avatar.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> addUser() async {
    try {
      final String res = await rootBundle.loadString('assets/users.json');
      final data = json.decode(res);

      if (data is List) {
        for (var item in data) {
          print(item);
          var url = Uri.parse('http://10.0.2.2:1337/api/users/');
          var response = await http.post(
            url,
            headers: <String, String>{
              'Authorization': 'Bearer $token',
            },
            body: <String, String>{
              'name': item['name'],
              'email': item['email'],
              'team': item['team'],
              'role': item['role'],

            }
          );

          if (response.statusCode == 201) {
            print('User added');
          } else {
            print('Failed to add user. Status code: ${response.statusCode}');
            print(response.body);
          }
        }
      } else {
        print("JSON data is not a list");
      }
    } catch (e) {
      print(e);
    }
  }

  // static updateUid() {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final User? user = auth.currentUser;
  //   final uid = user!.uid;
  //   CollectionReference fbTask = FirebaseFirestore.instance.collection('Emp');
  //   //add uid to firebase where email is equal to email
  //   fbTask
  //       .where('Email', isEqualTo: user.email)
  //       .get()
  //       .then((value) => value.docs[0].reference.update({'Id': uid}));
  // }


  static Future<void> addTask(Task task) async {
    try{
      var url = Uri.parse('http://10.0.2.2:1337/api/tasks/');
      print('Adding task');
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token',
        },
        body: <String, String>{
          'title': task.title,
          'description': task.description,
          'status': task.status,
          'team': task.dep,
          'startDate': task.startDate.toString(),
          'endDate': task.endDate.toString(),
          'emp': task.emp.join(','), // Convert List<String> to String
          'mainUser': mainUser.id,
          'projectId': currentProjectId,
        },
      );
      print(response.statusCode);
      if(response.statusCode == 201) {
        projectTasks.clear();
        print('Task added');
      } else {
        throw Exception('Failed to add task.');
      }

    } catch (e) {
      print(e);
    }
  }
  static Future<void> createUser(
      {required String name,
        required String email,
        required String role,
        required String dep}) async {
    //create firebase auth user with email and password
    try {

    } on Exception catch (e) {
      print(e);
    }
  }

  //update Uid of all Employees in firebase to match their Uid in firebase auth
  static updateUID() async {

  }

  static Future<void> updateTask(Task task) async {
    try {
      var url = Uri.parse('http://10.0.2.2:1337/api/tasks/${task.id}');
      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token',
        },
        body: <String, String>{
          'title': task.title,
          'description': task.description,
          'status': task.status,
          'team': task.dep,
          'startDate': task.startDate.toString(),
          'endDate': task.endDate.toString(),
        },
      );

      if(response.statusCode == 200) {
        tasks.clear();
        projectTasks.clear();
        print('Task updated');
      } else {
        throw Exception('Failed to update task.');
      }
    } catch (e) {
      print(e);
    }
  }

  //update emp list of task from uid to name
  static updateTaskEMP() {
    for (Task task in tasks) {
      for (var i = 0; i < task.emp.length; i++) {
        if (empMap[task.emp[i]] != null) {
          task.emp[i] = empMap[task.emp[i]].name;
        } else {
          // print('No employee found for id ${task.emp[i]}');
        }
      }
    }
  }
  static updateDepEMP() {
    for (Dep dep in deps) {
      for (var i = 0; i < dep.emp.length; i++) {
        dep.emp[i] = empMap[dep.emp[i]].name;
      }
    }
  }

  static void initMap() {
    empMap = {for (var e in employees) e.id: e};
    depMap = {for (var d in deps) d.name: d.emp};
  }

  static reset() {
    employees.clear();
    deps.clear();
    empMap.clear();
    depMap.clear();
    tasks.clear();
    projects.clear();
    projectTasks.clear();
  }
}
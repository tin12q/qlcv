import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:qlcv/model/dep.dart';
import 'package:qlcv/model/task.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'emp.dart';
//import '../firebase_options.dart';

class DBHelper {
  static List<Task> tasks = [];
  static Employee mainUser =
      Employee(name: '', email: '', dep: '', role: '', id: '');
  static List<Employee> employees = [];
  static List<Dep> deps = [];
  static var empMap = {};
  static var depMap = {};
  static Future<void> getEmp() async {
    try {
      var db = FirebaseFirestore.instance;
      CollectionReference cr = db.collection('Emp');
      QuerySnapshot qs = await cr.get();
      for (var doc in qs.docs) {
        //if (doc['Role'] == 'Emp') {
        employees.add(Employee(
            name: doc['Name'],
            email: doc['Email'],
            dep: doc['Dep'],
            role: doc['Role'],
            id: doc['Id']));
        //}
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> getDep() async {
    try {
      var qs = await FirebaseFirestore.instance
          .collection('Department')
          .orderBy('Name')
          .get();
      //TODO: get dep
      for (var doc in qs.docs) {
        deps.add(Dep(name: doc['Name'], emp: List<String>.from(doc['Emp'])));
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> updateDep() async {
    try {
      for (Employee e in employees) {
        await FirebaseFirestore.instance
            .collection('Department')
            .where('Name', isEqualTo: e.dep)
            .get()
            .then((value) => value.docs[0].reference.update({
                  'Emp': FieldValue.arrayUnion([e.id])
                }));
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> getMainUser({required String email}) async {
    try {
      var db = FirebaseFirestore.instance;
      CollectionReference cr = db.collection('Emp');
      var doc = await cr.where('Email', isEqualTo: email).get();
      mainUser = Employee(
          name: doc.docs[0]['Name'],
          email: email,
          dep: doc.docs[0]['Dep'],
          role: doc.docs[0]['Role'],
          id: doc.docs[0]['Id']);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  static Future<void> taskUpdate() async {
    try {
      CollectionReference cr = FirebaseFirestore.instance.collection('Tasks');
      QuerySnapshot qs = (mainUser.role == 'Admin')
          ? await cr.orderBy('Status').get()
          : await cr
              .orderBy('Status')
              .where('Dep', isEqualTo: mainUser.dep)
              .get();
      for (var doc in qs.docs) {
        tasks.add(Task(
            title: doc['Title'],
            description: doc['Desc'],
            status: doc['Status'],
            dep: doc['Dep'],
            startDate: (doc['Start'] as Timestamp).toDate(),
            endDate: (doc['End'] as Timestamp).toDate(),
            emp: List<String>.from(doc['Emp'])));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // static Future<void> taskUpdate() async {
  //   switch (mainUser.role) {
  //     case 'Admin':
  //       getTask();
  //       break;
  //     case 'Dep':
  //       getTaskMan(dep: mainUser.dep);
  //       break;
  //     case 'Employee':
  //       getTaskMan(dep: mainUser.dep);
  //       break;
  //   }
  //   //await cr.add({'title': 'test', 'description': 'test', 'status': 'test', 'startDate': 'test', 'endDate': 'test'});
  // }

  // static Future<void> getTask() async {
  //   try {
  //     var db = FirebaseFirestore.instance;
  //     CollectionReference cr = db.collection('tasks');
  //     QuerySnapshot qs = await cr.get();
  //     for (var doc in qs.docs) {
  //       tasks.add(Task(
  //           title: doc['Title'],
  //           description: doc['Description'],
  //           status: doc['Status'],
  //           dep: doc['Department'],
  //           startDate: (doc['Start Date'] as Timestamp).toDate(),
  //           endDate: (doc['Due Date'] as Timestamp).toDate()));
  //     }
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print(e);
  //   }
  // }

  // static Future<void> getTaskMan({required String dep}) async {
  //   try {
  //     var db = FirebaseFirestore.instance;
  //     CollectionReference cr = db.collection('tasks');
  //     QuerySnapshot qs = await cr.where('Department', isEqualTo: dep).get();
  //     for (var doc in qs.docs) {
  //       tasks.add(Task(
  //           title: doc['Title'],
  //           description: doc['Description'],
  //           status: doc['Status'],
  //           dep: doc['Department'],
  //           startDate: (doc['Start Date'] as Timestamp).toDate(),
  //           endDate: (doc['Due Date'] as Timestamp).toDate()));
  //     }
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print(e);
  //   }
  // }

  static Future<void> addTask(Task task) async {
    try {
      CollectionReference fbTask =
          FirebaseFirestore.instance.collection('Tasks');
      fbTask.add({
        'Title': task.title,
        'Desc': task.description,
        'Status': task.status,
        'Start': Timestamp.fromDate(task.startDate),
        'Dep': task.dep,
        'End': Timestamp.fromDate(task.endDate),
        'Emp': task.emp,
      });
    } on Exception catch (e) {
      // TODO:
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

  static Future<void> createUser(
      {required String name,
      required String email,
      required String role,
      required String dep}) async {
    //create firebase auth user with email and password
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      _auth.createUserWithEmailAndPassword(email: email, password: 'abcdef');
      //get this user uid
      final User? user = _auth.currentUser;
      final uid = user!.uid;

      CollectionReference fbTask = FirebaseFirestore.instance.collection('Emp');

      fbTask.add({
        'Name': name,
        'Email': email,
        'Role': role,
        'Dep': dep,
        'Id': uid,
      });
      //append uid to department emp list in firebase where department name is equal to dep
      FirebaseFirestore.instance
          .collection('Department')
          .where('Name', isEqualTo: dep)
          .get()
          .then((value) => value.docs[0].reference.update({
                'Emp': FieldValue.arrayUnion([uid])
              }));
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  //update Uid of all Employees in firebase to match their Uid in firebase auth
  static updateUID() async {
    try {
      CollectionReference fbTask = FirebaseFirestore.instance.collection('Emp');
      fbTask.get().then((value) => {
            for (var doc in value.docs)
              {
                FirebaseAuth.instance.signOut(),
                //delay to allow signout
                Future.delayed(const Duration(seconds: 2)),
                FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: doc['Email'],
                  password: 'abcdef',
                ),
                Future.delayed(const Duration(seconds: 2)),
                doc.reference
                    .update({'Id': FirebaseAuth.instance.currentUser!.uid})
              }
          });
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  //update emp list of task from uid to name
  static updateTaskEMP() {
    for (Task task in tasks) {
      for (var i = 0; i < task.emp.length; i++) {
        task.emp[i] = empMap[task.emp[i]].name;
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
  }
}

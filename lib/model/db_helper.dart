import 'package:qlcv/model/task.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'emp.dart';
//import '../firebase_options.dart';

class DBHelper {
  static List<Task> tasks = [];
  static Employee mainUser =
      Employee(name: '', email: '', dep: '', role: '', id: '');
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
      var db = FirebaseFirestore.instance;

      CollectionReference cr = db.collection('tasks');
      QuerySnapshot qs = (mainUser.role == 'Admin')
          ? await cr.get()
          : await cr.where('Department', isEqualTo: mainUser.dep).get();
      //QuerySnapshot qs = await cr.get();
      //print(mainUser.dep);
      // await FirebaseFirestore.instance
      //     .collection('tasks')
      //     .where('Department', isEqualTo: mainUser.dep)
      //     .get()
      //     .then((value) => {
      //           for (var doc in value.docs)
      //             {
      //               tasks.add(Task(
      //                   title: doc['Title'],
      //                   description: doc['Description'],
      //                   status: doc['Status'],
      //                   dep: doc['Department'],
      //                   startDate: (doc['Start Date'] as Timestamp).toDate(),
      //                   endDate: (doc['Due Date'] as Timestamp).toDate()))
      //             }
      //         });
      for (var doc in qs.docs) {
        tasks.add(Task(
            title: doc['Title'],
            description: doc['Description'],
            status: doc['Status'],
            dep: doc['Department'],
            startDate: (doc['Start Date'] as Timestamp).toDate(),
            endDate: (doc['Due Date'] as Timestamp).toDate()));
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

  static void addTask(Task task) {
    CollectionReference fbTask = FirebaseFirestore.instance.collection('tasks');
    fbTask.add({
      'title': task.title,
      'description': task.description,
      'status': task.status,
      'startDate': task.startDate,
      'endDate': task.endDate,
    });
  }

  static reset() {
    tasks.clear();
  }
}

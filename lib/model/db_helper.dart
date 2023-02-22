import 'package:qlcv/model/task.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import '../firebase_options.dart';

class DBHelper {
  static List<Task> tasks = [];
  static Future<void> taskUpdate() async {


      try {
        var db = FirebaseFirestore.instance;


        CollectionReference cr = db.collection('tasks');
        QuerySnapshot qs = await cr.get();
        qs.docs.forEach((doc) {
          tasks.add(Task(
              title: doc['Title'],
              description: doc['Description'],
              status: doc['Status'],
              dep: doc['Department'],
              startDate: (doc['Start Date'] as Timestamp).toDate(),
              endDate: (doc['Due Date'] as Timestamp).toDate()));
        });


      } catch (e) {
        // ignore: avoid_print
        print(e);
      }

    //await cr.add({'title': 'test', 'description': 'test', 'status': 'test', 'startDate': 'test', 'endDate': 'test'});
  }

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
}

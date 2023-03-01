import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home_page.dart';
//import 'model/task.dart';

import 'route/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await FirebaseFirestore.instance
  //     .collection('Emp')
  //     .get()
  //     .then((value) async => {
  //           for (var doc in value.docs)
  //             {
  //               await FirebaseAuth.instance.signOut(),
  //               //delay to allow signout
  //               Future.delayed(const Duration(seconds: 2)),
  //               await FirebaseAuth.instance.signInWithEmailAndPassword(
  //                 email: doc['Email'],
  //                 password: 'abcdef',
  //               ),
  //               Future.delayed(const Duration(seconds: 2)),
  //               await doc.reference
  //                   .update({'Id': FirebaseAuth.instance.currentUser!.uid})
  //             }
  //         });
  // await DBHelper.getEmp();
  // for (var i = 1; i <= 20; i++) {
  //   var status = ['Late', 'Done', 'Pending'];
  //   var random = new Random();
  //   var index = random.nextInt(status.length);
  //   List<String> emp = [];
  //   var numbers = random.nextInt(DBHelper.employees.length);
  //   for (var j = 0; j < numbers; j++) {
  //     emp.add(DBHelper.employees[j].id);
  //   }
  //   String dep = 'Dep' + (random.nextInt(3) + 1).toString();
  //   await DBHelper.addTask(Task(
  //     title: 'Task $i',
  //     description: 'Description $i',
  //     status: status[index],
  //     emp: emp,
  //     dep: dep,
  //     startDate: DateTime(2023, 2, 28 - numbers),
  //     endDate:
  //         DateTime(2023, 2, (status[index] != 'Pending') ? 28 - index : 28),
  //   ));
  // }
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => SignInPage(),
      '/home': (context) => const HomePage(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qlcv/home_page.dart';
import 'package:qlcv/model/db_helper.dart';

import '../model/color_picker.dart';
import '../model/task.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Sign in',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: ColorPicker.accent),
                  ),
                  const SizedBox(height: 50.0),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 8.0,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorPicker.accent),
                                ),
                                labelStyle:
                                    TextStyle(color: ColorPicker.accent),
                                labelText: 'Email',
                              ),
                              cursorColor: ColorPicker.accent,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorPicker.accent),
                                ),
                                //selected color

                                labelStyle:
                                    TextStyle(color: ColorPicker.accent),
                                labelText: 'Password',
                              ),
                              cursorColor: ColorPicker.accent,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 25.0),
                  Container(
                    width: 120,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 8.0,
                        backgroundColor: ColorPicker.accent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      onPressed: _isLoading ? null : _signIn,
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: ColorPicker.accent,
                              backgroundColor: ColorPicker.background,
                            )
                          : const Text('Sign In'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
      // var db = FirebaseFirestore.instance;
      // var cr = db.collection('Emp');
      // //select key from collection emp where email = email
      // var doc = await cr
      //     .where('Email', isEqualTo: _emailController.text.trim())
      //     .get();
      await DBHelper.getMainUser(email: _emailController.text.trim());

      //randomly create 10 user
      // for (int i = 10; i < 30; i++) {
      //   //random generate role [Admin,Dep,Emp]
      //   var role = ['Admin', 'Dep', 'Emp'];
      //   var random = new Random();
      //   var index = random.nextInt(role.length);

      //   await DBHelper.createUser(
      //     name: 'User $i',
      //     email: 'acc$i@${role[index].toUpperCase()}.com',
      //     role: role[index],
      //     dep: 'Dep$i',
      //   );
      // }
      //randomly create 10 tasks
      // await DBHelper.getEmp();
      //  for (var i = 1; i <= 10; i++) {
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
      //await DBHelper.updateDep();
      //change route home
      //await DBHelper.updateUID();

      //updateDep

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred, please check your credentials';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(errorMessage, style: TextStyle(color: ColorPicker.primary)),
          backgroundColor: ColorPicker.accent,
          duration: Duration(seconds: 5),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

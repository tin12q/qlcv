import 'dart:math';

import 'package:flutter/material.dart';
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
                                labelText: 'Username',
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

      await DBHelper.logIn(
        email: _emailController.text,
        password: _passwordController.text,
      );

    } on Exception catch (e) {
      // * Create User to
      String errorMessage = 'An error occurred, please check your credentials';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage,
              style: const TextStyle(color: ColorPicker.primary)),
          backgroundColor: ColorPicker.accent,
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (route) => false,
      );
    }
  }
}

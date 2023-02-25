import 'package:flutter/material.dart';
import 'package:qlcv/model/db_helper.dart';

class Menu extends StatefulWidget{
  const Menu({Key? key}) : super(key: key);
  @override
  State<Menu> createState() => _MenuState();
}
class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Menu',
            ),
            //logut button
            ElevatedButton(
              onPressed: () {
                //sign out with firebase
                logout(context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
  void logout(BuildContext context) {
    // TODO: Implement logout functionality
    // For example, clear the user's session or token
    // And navigate to the login page

    // Navigate to the login page
    DBHelper.reset();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
          (route) => false,
    );
  }
}

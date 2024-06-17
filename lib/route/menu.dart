import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:qlcv/model/db_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Menu extends StatefulWidget {
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
            if (DBHelper.imageFile != null)
              CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(DBHelper.imageFile!),
              ),


            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickAvatar,
              child: const Text('Set Avatar'),
            ),
            const Text(
              'Menu',
            ),
            ElevatedButton(
              onPressed: () {
                logout(context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAvatar() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      // Get the path of the selected image file
      DBHelper.imagePath = result.files.single.path;

      // Load the image file and update the avatar
      if (DBHelper.imagePath != null) {
        setState(() {
          DBHelper.imageFile = File(DBHelper.imagePath!); // Set the imageFile in DBHelper to the selected image
        });

        // Upload the image file
        await DBHelper.saveImage();

        // Update the avatar
        setState(() {});
      }
    }
  }

  void logout(BuildContext context) async {
    DBHelper.reset();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
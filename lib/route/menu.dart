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
  Uint8List? _avatarImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (DBHelper.mainUser.ava != null)
              CircleAvatar(
                radius: 50,
                backgroundImage: CachedNetworkImageProvider(DBHelper.mainUser.ava),
              )
            else
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.person),
              ),

            const SizedBox(height: 20),
            const Text(
              'Menu',
            ),
            // ElevatedButton(onPressed:
            //     _pickAvatar,
            //     child: const Text('Set Avatar')),
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
      String? imagePath = result.files.single.path;

      // Load the image file and update the avatar
      if (imagePath != null) {
        setState(() {
          _avatarImage = File(imagePath).readAsBytesSync();
        });
      }
    }
  }


  void logout(BuildContext context) async {
    DBHelper.reset();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}

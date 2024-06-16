import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';

class ChangePictureScreen extends StatefulWidget {
  @override
  _ChangePictureScreenState createState() => _ChangePictureScreenState();
}

class _ChangePictureScreenState extends State<ChangePictureScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateAvatar(BuildContext context) async {
    if (_imageFile != null) {
      // Update avatar in AuthState and shared preferences
      await Provider.of<AuthState>(context, listen: false).setAvatar(_imageFile!.path);
      Navigator.pop(context); // 返回上一页面
    }
  }

  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          '修改头像',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: _imageFile != null
                  ? FileImage(_imageFile!)
                  : (authState.avatarPath != null
                      ? FileImage(File(authState.avatarPath!))
                      : AssetImage('images/vv.jpg')) as ImageProvider,
              radius: 80,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('选择图片'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _updateAvatar(context),
              child: Text('修改头像'),
            ),
          ],
        ),
      ),
    );
  }
}

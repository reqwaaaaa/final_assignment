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
        backgroundColor: Color.fromARGB(255, 183, 220, 255),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text(
          '修改头像',
          style: TextStyle(
            fontFamily: "Font3",
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
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

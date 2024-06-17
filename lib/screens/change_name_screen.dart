import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';

class ChangeNameScreen extends StatefulWidget {
  @override
  _ChangeNameScreenState createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen> {
  TextEditingController _newNameController = TextEditingController();

  void _showConfirmationDialog(BuildContext context, String newName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('确认修改昵称'),
          content: Text('你确定要将昵称修改为 "$newName" 吗？'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 关闭对话框
              },
              child: Text('否'),
            ),
            TextButton(
              onPressed: () async {
                // 在此处实现修改昵称的逻辑
                await Provider.of<AuthState>(context, listen: false).setUsername(newName);
                Navigator.of(context).pop(); // 关闭对话框
                 Navigator.of(context).pop(); // 返回上一个页面
              },
              child: Text('是'),
            ),
          ],
        );
      },
    );
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
          '更改昵称',
          style: TextStyle(
            fontFamily: "Font3",
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.normal,
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
      backgroundColor: Color.fromARGB(255, 226, 240, 254),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '旧昵称: ${authState.username}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _newNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '输入新昵称',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String newName = _newNameController.text;
                _showConfirmationDialog(context, newName);
              },
              child: Text('修改昵称'),
            ),
          ],
        ),
      ),
    );
  }
}

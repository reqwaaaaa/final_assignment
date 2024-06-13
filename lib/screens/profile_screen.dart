import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 240, 254),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('用户名: ${authState.username}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/change_password');
              },
              child: Text('修改密码'),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              // 添加用户头像显示部分
              backgroundImage: AssetImage('images/vv.jpg'), // 从本地加载头像图片
              radius: 50, // 头像半径
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dod1/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('个人信息'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color.fromARGB(255, 226, 240, 254),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.blue, // 蓝色背景
            child: Row(
              children: [
                CircleAvatar(
                  // 用户头像
                  backgroundImage: AssetImage('images/vv.jpg'),
                  radius: 50,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    '用户名: ${authState.username}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24, // 增大字体大小
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/change_nickname'); // 修改昵称按钮点击事件
                    },
                    text: '修改昵称',
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/change_avatar'); // 修改头像按钮点击事件
                    },
                    text: '修改头像',
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/change_password');
                    },
                    text: '修改密码',
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/history'); // 历史记录按钮点击事件
                    },
                    text: '历史记录',
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    },
                    text: '退出登录',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

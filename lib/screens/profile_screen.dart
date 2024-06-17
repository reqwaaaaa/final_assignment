import 'package:dod1/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  late ImageProvider<Object> _avatarImage; // 添加_avatarImage变量

  _ProfileScreenState() {
    _avatarImage = AssetImage('images/vv.jpg'); // 初始化_avatarImage变量
  }

  void updateAvatar(String imagePath) {
    setState(() {
      _avatarImage = AssetImage(imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context);

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   title: Text('个人信息'),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
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
                  backgroundImage: _avatarImage ?? AssetImage('images/vv.jpg'),
                  // 从本地加载头像图片，如果没有则使用默认头像
                  radius: 50,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    '用户名: ${authState.username}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24, // 增大字体大小
                      fontWeight: FontWeight.normal,
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/change_nickname');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.party_mode,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '修改昵称',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 25, 125, 255),
                      backgroundColor: Color.fromARGB(255, 183, 220, 255),
                      minimumSize: Size(double.infinity, 60), // 设置按钮的最小尺寸
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final pickedFile = await _imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (pickedFile != null) {
                        updateAvatar('images/${pickedFile.name}'); // 更新头像图片
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.party_mode,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '修改头像',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 25, 125, 255),
                      backgroundColor: Color.fromARGB(255, 183, 220, 255),
                      minimumSize: Size(double.infinity, 60), // 设置按钮的最小尺寸
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/change_password');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.party_mode,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '修改密码',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 25, 125, 255),
                      backgroundColor: Color.fromARGB(255, 183, 220, 255),
                      minimumSize: Size(double.infinity, 60), // 设置按钮的最小尺寸
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/history'); // 历史记录按钮点击事件
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.party_mode,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '历史记录',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 25, 125, 255),
                      backgroundColor: Color.fromARGB(255, 183, 220, 255),
                      minimumSize: Size(double.infinity, 60), // 设置按钮的最小尺寸
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.party_mode,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '退出登录',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 25, 125, 255),
                      backgroundColor: Color.fromARGB(255, 183, 220, 255),
                      minimumSize: Size(double.infinity, 60), // 设置按钮的最小尺寸
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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

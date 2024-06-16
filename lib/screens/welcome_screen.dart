import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // 延时5秒后关闭页面
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/login'); // 替换为你的登录页面路由
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      backgroundColor: Colors.lightBlue[100], // 设置页面背景颜色为浅蓝色
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                '欢迎使用！', // 第一行文字
                style: TextStyle(
                    fontFamily: "Font3",
                    fontSize: 36,
                    color: Colors.white), // 设置文字大小和颜色
              ),
            ),
            SizedBox(height: 10), // 调整行间距
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '命运飞镖', // 第二行文字
                style: TextStyle(
                    fontFamily: "Font3",
                    fontSize: 24,
                    color: Colors.white), // 设置文字大小和颜色
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'FortuneFling', // 第三行文字
                style:
                    TextStyle(fontSize: 44, color: Colors.white), // 设置文字大小和颜色
              ),
            ),
            SizedBox(height: 20), // 调整行间距
            Image.asset(
              'images/10001.png', // 图片路径
              height: 200, // 放大图片
            ),
            SizedBox(height: 20), // 调整行间距
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '选择困难症福音', // 图标下面第一行文字
                style: TextStyle(
                    fontFamily: "Font3",
                    fontSize: 20,
                    color: Colors.white), // 设置文字大小和颜色
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '你值得拥有！', // 图标下面第二行文字
                style:
                    TextStyle(
                    fontFamily: "Font3",
                    fontSize: 20, color: Colors.white), // 设置文字大小和颜色
              ),
            ),
          ],
        ),
      ),
    );
  }
}

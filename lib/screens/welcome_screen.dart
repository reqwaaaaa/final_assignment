import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _slidePosition = 0.0;
  double _maxSlideDistance = 333.0; // 调整最大滑动距离
  bool _isUnlocked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: Matrix4.translationValues(_slidePosition, 0, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '欢迎使用', // 第一行文字
                      style: TextStyle(
                        fontFamily: "Font3",
                        fontSize: 50,
                        color: Colors.white,
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
                  SizedBox(height: 50), // 调整行间距
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '命运飞镖', // 第二行文字
                      style: TextStyle(
                        fontFamily: "Font3",
                        fontSize: 30,
                        color: Colors.white,
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
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'FortuneFling', // 第三行文字
                      style: TextStyle(
                        fontFamily: "Font4",
                        fontSize: 30,
                        color: Colors.white,
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
                  SizedBox(height: 20), // 调整行间距
                  Image.asset(
                    'images/10001.png', // 图片路径
                    height: 200, // 放大图片
                  ),
                  SizedBox(height: 50), // 调整行间距
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '选择困难症福音,你值得拥有~', // 图标下面第一行文字
                      style: TextStyle(
                        fontFamily: "Font3",
                        fontSize: 20,
                        color: Colors.white,
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
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 28,
            left: 50,
            right: 50,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _slidePosition += details.primaryDelta!;
                  if (_slidePosition < 0) {
                    _slidePosition = 0;
                  } else if (_slidePosition > _maxSlideDistance) {
                    _slidePosition = _maxSlideDistance;
                  }
                });
              },
              onHorizontalDragEnd: (details) {
                if (_slidePosition >= _maxSlideDistance) {
                  setState(() {
                    _isUnlocked = true;
                  });
                  Navigator.pushReplacementNamed(context, '/login');
                } else {
                  setState(() {
                    _slidePosition = 0.0;
                  });
                }
              },
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width - 32,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 135, 206, 250),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: _slidePosition,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(0, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '滑动解锁',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

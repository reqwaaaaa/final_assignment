import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 162, 207, 255),
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
          '管理员面板',
          style: TextStyle(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/manage_questions');
              },
              child: Text('管理问题'),
            ),
            ElevatedButton(
              onPressed: () async {
                List<Map<String, String>> users = await authState.getAllUsers();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('用户列表'),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var user in users)
                              Text('${user.keys.first}: ${user.values.first}'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text('查看用户'),
            ),
          ],
        ),
      ),
    );
  }
}
/*管理员面板，用于展示管理员的功能选项。它包含两个按钮：

“管理问题”按钮：点击后将导航到问题管理页面。
“查看用户”按钮：点击后将显示用户列表的对话框。
在构建时，它使用 Provider.of 获取 AuthState 对象，以便与认证状态进行交互。在点击“查看用户”按钮时，它会调用 authState.getAllUsers() 方法来获取所有用户的信息，并将其显示在对话框中。

其中，对话框包含一个标题 “用户列表”，以及一个包含所有用户信息的列。每个用户的信息都以 “key: value” 的形式显示，其中键为用户名，值为用户ID。*/
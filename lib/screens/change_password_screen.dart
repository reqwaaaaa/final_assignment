import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController(); // 添加确认密码输入框
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
          '修改密码',
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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _oldPasswordController,
                labelText: '旧密码',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入旧密码';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: _newPasswordController,
                labelText: '新密码',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入新密码';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomTextField(
                // 添加确认密码输入框
                controller: _confirmPasswordController,
                labelText: '确认密码',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请确认新密码';
                  } else if (value != _newPasswordController.text) {
                    return '确认密码与新密码不匹配';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                text: '修改密码',
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? username =
                        Provider.of<AuthState>(context, listen: false).username;
                    String? storedPassword = prefs.getString(username!);
                    if (_oldPasswordController.text == storedPassword) {
                      await prefs.setString(
                          username, _newPasswordController.text);
                      _oldPasswordController.clear(); // 清空输入框
                      _newPasswordController.clear(); // 清空输入框
                      _confirmPasswordController.clear(); // 清空输入框
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('密码修改成功')),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('旧密码错误')),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*用于用户修改密码。它包含以下功能：

旧密码输入框：用户输入旧密码。
新密码输入框：用户输入新密码。
确认密码输入框：用户确认新密码。
修改密码按钮：用户点击此按钮后，将根据输入的内容验证并更新密码。
在构建时，组件使用 Form 和 GlobalKey<FormState> 进行表单验证。用户输入的旧密码将与存储在 SharedPreferences 中的密码进行比较，以验证其准确性。如果密码验证通过，新密码将存储在 SharedPreferences 中，并显示一个提示消息，表示密码修改成功。*/
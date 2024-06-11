import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('注册')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _usernameController,
                labelText: '用户名',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入用户名';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _passwordController,
                labelText: '密码',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入密码';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                text: '注册',
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await Provider.of<AuthState>(context, listen: false)
                        .register(
                            _usernameController.text, _passwordController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('注册成功，请登录')),
                    );
                    Navigator.pushReplacementNamed(context, '/');
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

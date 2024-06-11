import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
/*
labelText：输入框的标签文本。
controller：用于控制输入框值的文本编辑控制器。
validator：可选参数，用于验证输入值的验证器函数。
obscureText：可选参数，控制输入文本是否被隐藏（例如，用于密码输入）。
在构建时，它返回一个TextFormField，其中包含指定的标签文本和边框样式。它还将提供的文本编辑控制器和验证器与输入框关联起来，以便进行输入控制和验证。
 */
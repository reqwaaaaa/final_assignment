import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
/*两个参数：按钮上显示的文本（text）和按钮按下时触发的回调函数（onPressed）。
返回一个ElevatedButton，当按钮被按下时，它会执行onPressed中指定的函数。
作用是封装了一个常见的按钮样式，使得在应用中使用按钮时更加方便和统一。 */
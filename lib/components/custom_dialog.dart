import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  CustomDialog(
      {required this.title, required this.content, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('取消'),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          child: Text('确定'),
        ),
      ],
    );
  }
}
/*
对话框的标题（title）、内容（content）和确认操作的回调函数（onConfirm）。

返回一个AlertDialog，其中包含指定的标题和内容。对话框还包含两个操作按钮：一个“取消”按钮和一个“确定”按钮。当用户点击“确定”按钮时，将调用onConfirm回调函数执行确认操作。
*/
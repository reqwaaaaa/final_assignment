import 'package:flutter/material.dart';

class TruthOrDareCard extends StatelessWidget {
  final Map<String, String> content;
  final VoidCallback onDelete;

  const TruthOrDareCard({
    Key? key,
    required this.content,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final question = content['content'] ?? ''; // 使用 'content' 键获取内容

    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(question),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}

/*
content：一个包含卡片内容的 Map，其中键为 'question'，值为真心话或大冒险的文本内容。
onDelete：当用户点击删除按钮时触发的回调函数。
返回一个 Card，其中包含一个 ListTile。ListTile 包含标题部分，显示真心话或大冒险的内容，以及一个尾部部件，显示一个删除按钮。用户点击删除按钮时，将触发 onDelete 回调函数，用于执行删除操作。*/
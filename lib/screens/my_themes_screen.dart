import 'package:flutter/material.dart';

class MyThemesScreen extends StatelessWidget {
  final List<String> themes = [
    '主题1',
    '主题2',
    '主题3',
    '主题4'
  ]; // Replace with dynamic data

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
          '我的主题',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 226, 240, 254),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: themes.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(themes[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      // Share functionality
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Delete functionality
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

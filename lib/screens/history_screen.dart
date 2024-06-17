import 'package:dod1/components/custom_button.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
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
          "历史记录",
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, '/random_choice_history');
              },
              text: '随机选择结果',
            ),
            SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, '/truth_dare_history');
              },
              text: '真心话大冒险结果',
            ),
          ],
        ),
      ),
    );
  }
}

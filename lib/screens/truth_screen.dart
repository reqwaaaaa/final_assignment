import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import '../state/truth_or_dare_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TruthScreen extends StatelessWidget {
  final TextEditingController _truthController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('添加真心话')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _truthController,
                labelText: '真心话',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入真心话';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                text: '添加',
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Provider.of<TruthOrDareState>(context, listen: false)
                        .addTruthQuestion({'content': _truthController.text});
                    Navigator.pop(context);
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

class TruthPage extends StatefulWidget {
  @override
  _TruthPageState createState() => _TruthPageState();
}

class _TruthPageState extends State<TruthPage> {
  String question = '你最喜欢什么样的天气？';
  int questionIndex = 0;

  Future<void> fetchQuestion() async {
    final url = 'https://truth-dare.p.rapidapi.com/truthDareApi/truth';
    final headers = {
      'x-rapidapi-key': 'YOUR_API_KEY_HERE', // 替换为您的API密钥
      'x-rapidapi-host': 'truth-dare.p.rapidapi.com',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Response Data: $data');  // 打印响应数据进行调试
        setState(() {
          question = data['question'] ?? '未能获取问题';
          questionIndex += 1;
        });
      } else {
        print('Failed to load question: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          question = '加载问题失败';
          questionIndex += 1;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        question = '加载问题时发生错误';
        questionIndex += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
          '真心话',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 1), // 从下方进入
                    end: Offset(0, 0),   // 位置归零
                  ).animate(animation),
                  child: child,
                );
              },
            child: Container(
              width:MediaQuery.of(context).size.width * 0.9 ,
              height: MediaQuery.of(context).size.width * 0.9,
              key: ValueKey<int>(questionIndex), // 使用问题索引作为key,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 170, 207),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '真心话',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
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
                  SizedBox(height: 20),
                  Image.asset(
                    'images/heartbeat2.png',
                    height: 150,
                  ),
                  SizedBox(height: 20),
                  Text(
                    question,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      fetchQuestion();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    ),
                    child: Text(
                      '下一题',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

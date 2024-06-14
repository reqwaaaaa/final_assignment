import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import '../state/truth_or_dare_state.dart';
import 'dart:math';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle; // 用于读取 assets 中的文件
import 'package:animated_text_kit/animated_text_kit.dart'; // 导入 animated_text_kit

class DareScreen extends StatelessWidget {
  final TextEditingController _dareController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('添加大冒险')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _dareController,
                labelText: '大冒险',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入大冒险';
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
                        .addDareChallenge({'content': _dareController.text});
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

class DarePage extends StatefulWidget {
  @override
  _DarePageState createState() => _DarePageState();
}

class _DarePageState extends State<DarePage> {
  String question = '做100个深蹲。';
  int questionIndex = 0;
  List<String> questions = [];
  bool showColorize = false;
  List<Color> gradientColors = [
    Color.fromARGB(255, 95, 215, 255),
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 86, 235, 255),
  ];
  int colorIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _startColorAnimation();
  }

  Future<void> _loadQuestions() async {
    try {
      final contents = await rootBundle.loadString('assets/dare.txt');
      setState(() {
        questions =
            contents.split('\n').where((line) => line.isNotEmpty).toList();
        if (questions.isNotEmpty) {
          _getRandomQuestion();
        } else {
          question = '未找到任何问题';
        }
      });
    } catch (e) {
      print('Error reading questions file: $e');
      setState(() {
        question = '加载问题时发生错误';
      });
    }
  }

  void _getRandomQuestion() {
    if (questions.isNotEmpty) {
      final random = Random();
      setState(() {
        question = questions[random.nextInt(questions.length)];
        questionIndex += 1;
        showColorize = false;
      });
    }
  }

  void _showColorizeAnimation() {
    setState(() {
      showColorize = true;
    });
  }

  void _startColorAnimation() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      try {
        setState(() {
          colorIndex = (colorIndex + 1) % gradientColors.length;
        });
      } catch (e) {
        print('Caught exception in _startColorAnimation: $e');
        // 可以在这里添加错误处理逻辑
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
        title: Image.asset(
          'images/大冒险.png',
          height: 30,
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
                  end: Offset(0, 0), // 位置归零
                ).animate(animation),
                child: child,
              );
            },
            child: AnimatedContainer(
              duration: Duration(seconds: 5),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              key: ValueKey<int>(questionIndex), // 使用问题索引作为key
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    gradientColors[colorIndex],
                    gradientColors[(colorIndex + 1) % gradientColors.length],
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Image.asset(
                    'images/devil2.png',
                    height: 250,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            question,
                            textStyle: TextStyle(
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
                            speed: Duration(milliseconds: 100),
                          ),
                        ],
                        isRepeatingAnimation: false,
                        onFinished: _showColorizeAnimation,
                        key: ValueKey('typewriter'),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      _getRandomQuestion();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color.fromARGB(255, 30, 121, 233),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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

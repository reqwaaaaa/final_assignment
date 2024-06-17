import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/truth_or_dare_state.dart';
import '../components/custom_button.dart';

class ManageQuestionsScreen extends StatefulWidget {
  @override
  _ManageQuestionsScreenState createState() => _ManageQuestionsScreenState();
}

class _ManageQuestionsScreenState extends State<ManageQuestionsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _selectedAngle = 0;
  final _random = Random();
  List<String> _items = []; // 添加一个空的项目列表

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 360,
    ).animate(_controller)
      ..addListener(() {
        setState(() {
          _selectedAngle = _animation.value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    final truthOrDareState = Provider.of<TruthOrDareState>(context);

    // 更新项目列表
    _items = truthOrDareState.truthQuestions.isNotEmpty
        ? truthOrDareState.truthQuestions
            .map((question) => question['content'] ?? '')
            .toList()
        : ['暂无真心话'];

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
          '管理问题',
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
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/truth');
            },
            child: Text('添加真心话'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/dare');
            },
            child: Text('添加大冒险'),
          ),
          SizedBox(height: 20),
          YourWheelWidget(
            items: _items, // 将项目列表传递给您的轮盘组件
            angle: _selectedAngle, // 将选择的角度传递给您的轮盘组件
          ), // 替换为您的轮盘部件
          SizedBox(height: 20),
          CustomButton(
            text: '开始',
            onPressed: () {
              _controller.reset();
              _controller.forward().then((_) {
                // 动画完成后触发随机显示真心话或大冒险的对话框
                _showRandomDialog(truthOrDareState);
              });
            },
          ),
        ],
      ),
    );
  }

  void _showRandomDialog(TruthOrDareState truthOrDareState) {
    final bool isTruth = _random.nextBool();
    final int index = _random.nextInt(isTruth
        ? truthOrDareState.truthQuestions.length
        : truthOrDareState.dareChallenges.length);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isTruth ? '随机真心话' : '随机大冒险'),
          content: Text(
            isTruth
                ? (truthOrDareState.truthQuestions.isNotEmpty
                    ? truthOrDareState.truthQuestions[index]['content'] ??
                        '暂无真心话'
                    : '暂无真心话')
                : (truthOrDareState.dareChallenges.isNotEmpty
                    ? truthOrDareState.dareChallenges[index]['content'] ??
                        '暂无大冒险'
                    : '暂无大冒险'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('确定'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// 替换为您的轮盘部件
class YourWheelWidget extends StatelessWidget {
  final List<String> items;
  final double angle;

  YourWheelWidget({required this.items, required this.angle});

  @override
  Widget build(BuildContext context) {
    // 您的轮盘部件实现
    return Container(
      width: 100,
      height: 100,
      color: Colors.red, // 示例背景颜色
      child: Transform.rotate(
        angle: angle * pi / 180, // 将角度转换为弧度
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Center(
              child: Text(
                items[index],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_button.dart';
import '../components/truth_or_dare_card.dart';
import '../state/truth_or_dare_state.dart';
import 'dart:math';

class TruthOrDareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var truthOrDareState = Provider.of<TruthOrDareState>(context);

    return Scaffold(
      appBar: AppBar(title: Text('真心话大冒险')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/truth');
            },
            child: Text('真心话'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/dare');
            },
            child: Text('大冒险'),
          ),
          SizedBox(height: 20),
          CustomButton(
            text: '开始',
            onPressed: () {
              final truthOrDareState =
                  Provider.of<TruthOrDareState>(context, listen: false);
              final Random random = Random();
              final bool isTruth = random.nextBool();
              final List<Map<String, String>> questions = isTruth
                  ? truthOrDareState.truthQuestions
                  : truthOrDareState.dareChallenges;
              if (questions.isNotEmpty) {
                final int index = random.nextInt(questions.length);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(isTruth ? '随机真心话' : '随机大冒险'),
                      content: Text(
                        questions[index]['content'] ?? '暂无内容',
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
              } else {
                // 处理真心话或大冒险列表为空的情况
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(isTruth ? '真心话列表为空' : '大冒险列表为空'),
                      content: Text(
                        isTruth ? '请先添加真心话' : '请先添加大冒险',
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
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: truthOrDareState.truthQuestions.length,
              itemBuilder: (context, index) {
                return TruthOrDareCard(
                  content: truthOrDareState.truthQuestions[index],
                  onDelete: () {
                    truthOrDareState.removeTruthQuestion(
                      truthOrDareState.truthQuestions[index],
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: truthOrDareState.dareChallenges.length,
              itemBuilder: (context, index) {
                return TruthOrDareCard(
                  content: truthOrDareState.dareChallenges[index],
                  onDelete: () {
                    truthOrDareState.removeDareChallenge(
                      truthOrDareState.dareChallenges[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

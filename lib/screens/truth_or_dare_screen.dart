import 'package:dod1/screens/truth_screen.dart';
import 'package:flutter/material.dart';

import 'package:dod1/screens/dare_screen.dart';

// class TruthOrDareScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var truthOrDareState = Provider.of<TruthOrDareState>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text('真心话大冒险')),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pushNamed(context, '/truth');
//             },
//             child: Text('真心话'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pushNamed(context, '/dare');
//             },
//             child: Text('大冒险'),
//           ),
//           SizedBox(height: 20),
//           CustomButton(
//             text: '开始',
//             onPressed: () {
//               final truthOrDareState =
//                   Provider.of<TruthOrDareState>(context, listen: false);
//               final Random random = Random();
//               final bool isTruth = random.nextBool();
//               final List<Map<String, String>> questions = isTruth
//                   ? truthOrDareState.truthQuestions
//                   : truthOrDareState.dareChallenges;
//               if (questions.isNotEmpty) {
//                 final int index = random.nextInt(questions.length);
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: Text(isTruth ? '随机真心话' : '随机大冒险'),
//                       content: Text(
//                         questions[index]['content'] ?? '暂无内容',
//                       ),
//                       actions: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text('确定'),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               } else {
//                 // 处理真心话或大冒险列表为空的情况
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: Text(isTruth ? '真心话列表为空' : '大冒险列表为空'),
//                       content: Text(
//                         isTruth ? '请先添加真心话' : '请先添加大冒险',
//                       ),
//                       actions: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text('确定'),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               }
//             },
//           ),
//           SizedBox(height: 20),
//           Expanded(
//             child: ListView.builder(
//               itemCount: truthOrDareState.truthQuestions.length,
//               itemBuilder: (context, index) {
//                 return TruthOrDareCard(
//                   content: truthOrDareState.truthQuestions[index],
//                   onDelete: () {
//                     truthOrDareState.removeTruthQuestion(
//                       truthOrDareState.truthQuestions[index],
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: truthOrDareState.dareChallenges.length,
//               itemBuilder: (context, index) {
//                 return TruthOrDareCard(
//                   content: truthOrDareState.dareChallenges[index],
//                   onDelete: () {
//                     truthOrDareState.removeDareChallenge(
//                       truthOrDareState.dareChallenges[index],
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class TruthOrDareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 162, 202),
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
          "真心话大冒险",
          style: TextStyle(
            fontFamily: "Font3",
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TruthPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 170, 207),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                          'images/heartbeat.png',
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DarePage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 135, 206, 250),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '大冒险',
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
                          'images/devil.png',
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

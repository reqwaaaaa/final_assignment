import 'dart:math';
import 'package:flutter/material.dart';
import 'package:roulette/roulette.dart';
import '../components/arrow.dart'; // 根据需要替换为自定义箭头部件

class RoulettePage extends StatefulWidget {
  final List<String> options;

  const RoulettePage({Key? key, required this.options}) : super(key: key);

  @override
  State<RoulettePage> createState() => _RoulettePageState();
}

class _RoulettePageState extends State<RoulettePage>
    with SingleTickerProviderStateMixin {
  late RouletteController _controller;
  bool _clockwise = true;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = RouletteController(
      vsync: this,
      group: RouletteGroup.uniform(
        widget.options.length,
        textBuilder: (index) => widget.options[index],
        colorBuilder: (index) => _assignColor(index),
      ),
    );
  }

  Color _assignColor(int index) {
    // Define a list of custom colors
    final List<Color> customColors = [
      Color.fromARGB(255, 42, 128, 227),
      Color.fromARGB(255, 170, 212, 250),
      Color.fromARGB(255, 44, 159, 239),
      Color.fromARGB(255, 8, 80, 180),
      Color.fromARGB(255, 255, 204, 97),
      Color.fromARGB(255, 253, 230, 176),
    ];
    return customColors[index % customColors.length];
  }

  void _startSpinning() {
    _controller.rollTo(
      _random.nextInt(widget.options.length),
      clockwise: _clockwise,
      offset: _random.nextDouble(),
    );
  }

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
          "转盘页面",
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    MyRoulette(controller: _controller),
                    Positioned(
                      top: 40, 
                      child: const Arrow(),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _startSpinning,
              child: Text('开始！'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 158, 208, 255),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 100), 
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MyRoulette extends StatelessWidget {
  const MyRoulette({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RouletteController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [Colors.white, Colors.blue.shade200],
          stops: [0.7, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8.0,
            spreadRadius: 2.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Roulette(
          controller: controller,
          style: const RouletteStyle(
            dividerThickness: 2.0,
            dividerColor: Colors.black,
            centerStickSizePercent: 0.05,
            centerStickerColor: Colors.black,
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}



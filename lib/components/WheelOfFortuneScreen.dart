import 'dart:math';
import 'package:flutter/material.dart';
import 'package:roulette/roulette.dart';

class WheelOfFortuneScreen extends StatefulWidget {
  final List<String> options;

  WheelOfFortuneScreen({required this.options});

  @override
  _WheelOfFortuneScreenState createState() => _WheelOfFortuneScreenState();
}

class _WheelOfFortuneScreenState extends State<WheelOfFortuneScreen>
    with SingleTickerProviderStateMixin {
  late RouletteController _controller;
  static final _random = Random();
  late int _currentIndex = 0; // State to hold the current index
  bool _isSpinning = false; // State to manage spinning state
  final List<Color> _customColors = [
    Color.fromARGB(255, 42, 128, 227),
    Color.fromARGB(255, 170, 212, 250),
    Color.fromARGB(255, 44, 159, 239),
    Color.fromARGB(255, 8, 80, 180),
    Color.fromARGB(255, 255, 204, 97),
    Color.fromARGB(255, 253, 230, 176),
  ];

  @override
  void initState() {
    super.initState();

    // Initialize RouletteGroup with custom colors
    List<Color> optionColors = _assignColors(widget.options.length);

    RouletteGroup group = RouletteGroup.uniform(
      widget.options.length,
      textBuilder: (index) => widget.options[index],
      colorBuilder: (index) => optionColors[index],
    );

    // Initialize RouletteController with the group and vsync
    _controller = RouletteController(vsync: this, group: group);

    // Listen to animation end event
    _controller.addListener(_onAnimationEnd);
  }

  @override
  void dispose() {
    _controller.removeListener(_onAnimationEnd);
    _controller.dispose();
    super.dispose();
  }

  // Handler for animation end
  void _onAnimationEnd() {
    // Determine the selected index when animation ends
    int selectedIndex = _random.nextInt(widget.options.length);
    setState(() {
      _currentIndex = selectedIndex;
      _isSpinning = false; // Set spinning state to false
    });
  }

  void _startSpin() {
    setState(() {
      _isSpinning = true; // Set spinning state to true
      int selectedIndex = _random.nextInt(widget.options.length);
      _controller.rollTo(selectedIndex); // Roll to the selected index
    });
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
                    _buildRoulette(),
                    if (!_isSpinning && _currentIndex != null)
                      _buildArrowIndicator(),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _isSpinning
                  ? null
                  : _startSpin, // Disable button when spinning
              child: Text('开始！'), // 停止按钮的文本
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 158, 208, 255), // 默认背景颜色
                foregroundColor: Colors.white, // 默认文本颜色
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoulette() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Colors.white, Colors.blue.shade200],
            stops: [0.7, 1.0],
          ),
          border: Border.all(color: Colors.blue, width: 4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Roulette(
            controller: _controller,
            style: const RouletteStyle(
              dividerThickness: 2.0,
              dividerColor: Colors.black,
              centerStickSizePercent: 0.05,
              centerStickerColor: Colors.black,
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArrowIndicator() {
    return Positioned(
      bottom: 20,
      child: CustomPaint(
        size: Size(40, 20), // Size of the triangle
        painter:
            _TrianglePainter(color: Color.fromARGB(255, 45, 129, 255)), // Custom painter for triangle
      ),
    );
  }

  List<Color> _assignColors(int count) {
    List<Color> colors = [];
    for (int i = 0; i < count; i++) {
      Color color;
      do {
        color = _customColors[_random.nextInt(_customColors.length)];
      } while (i > 0 && color == colors[i - 1]);
      colors.add(color);
    }
    return colors;
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path();
    path.moveTo(size.width / 2, 0); // Top point
    path.lineTo(size.width, size.height); // Bottom right point
    path.lineTo(0, size.height); // Bottom left point
    path.close(); // Close the path to form a triangle
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint since the triangle is static
  }
}

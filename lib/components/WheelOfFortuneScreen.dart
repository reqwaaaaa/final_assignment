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

  @override
  void initState() {
    super.initState();

    // Create a group with custom colors for each option
    List<RouletteUnit> units = [];
    for (int i = 0; i < widget.options.length; i++) {
      // Generate a random color for each option
      Color color = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
      units.add(RouletteUnit.noText(color: color));
    }

    RouletteGroup group = RouletteGroup.uniform(
      widget.options.length,
      textBuilder: (index) => widget.options[index],
      colorBuilder: (index) => units[index].color,
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
        title: Text(
          '转盘页面',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSpinning ? null : _startSpin, // Disable button when spinning
              child: Text('停！'), // 停止按钮的文本
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
          border: Border.all(color: Colors.blue, width: 2.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Roulette(
            controller: _controller,
            style: const RouletteStyle(
              dividerThickness: 2.0,
              dividerColor: Colors.black,
              centerStickSizePercent: 0.05,
              centerStickerColor: Colors.black,
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
        painter: _TrianglePainter(color: Colors.red), // Custom painter for triangle
      ),
    );
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

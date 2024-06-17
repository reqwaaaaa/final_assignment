import 'package:flutter/material.dart';

class Arrow extends StatelessWidget {
  const Arrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(40, 40),
      painter: ArrowPainter(),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final path = Path()
       ..moveTo(0, 0) // 左上角顶点
      ..lineTo(size.width, 0) // 右上角顶点
      ..lineTo(size.width / 2, size.height) // 底部中心点
      ..close(); // 闭合路径

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import '../components/custom_button.dart';

class SpinWheel extends StatefulWidget {
  final List<String> items;
  final VoidCallback onSpin;

  SpinWheel({required this.items, required this.onSpin});

  @override
  _SpinWheelState createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  late double selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpinBox(
          min: 0,
          max: widget.items.length - 1,
          value: selectedIndex,
          onChanged: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
        ),
        CustomButton(
          text: 'Spin',
          onPressed: () {
            // Trigger spin animation with selected index
            widget.onSpin();
          },
        ),
      ],
    );
  }
}

/*
items：一个包含转盘选项的字符串列表。
onSpin：当用户点击旋转按钮时触发的回调函数。
在构建时，它返回一个 Column，其中包含一个 SpinBox 组件和一个 CustomButton 组件。SpinBox 用于选择要显示的选项的索引，而 CustomButton 用于触发旋转动作。
*/
import 'dart:math';
import 'package:flutter/material.dart';



// A box simply for demonstration purpose for columns and rows
class Box extends StatelessWidget {
  // Random color selection.
  static final Random _rng = Random();
  static final List<Color> _colors = [
    Colors.red,
    Colors.amber,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.indigo,
  ];

  final double _height;
  final double _width;
  final Color _color;

  // Static getter for random color
  static Color get randomColor => _colors[ _rng.nextInt(_colors.length) ];

  // Named constructors for different sized Boxes
  Box.regular({ Key? key })
    : _height = 50, _width = 50, _color = randomColor, super(key: key);
  Box.large({ Key? key })
    : _height = 75, _width = 75, _color = randomColor, super(key: key);
  Box.small({ Key? key })
    : _height = 25, _width = 25, _color = randomColor, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        color: _color,
        border: Border.all(),
      ),
    );
  }
}


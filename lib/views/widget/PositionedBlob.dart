import 'package:flutter/material.dart';
import 'package:parent_app/core/colorsApp.dart';
import 'dart:math' as math;

class PositionedBlob extends StatelessWidget {
 
  final double? top, bottom, left, right;
  final double size;
  final int delay;

  PositionedBlob({this.top, this.bottom, this.left, this.right, required this.size, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, bottom: bottom, left: left, right: right,
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 4),
        tween: Tween<double>(begin: 0, end: 10),
        builder: (context, double val, child) {
          return Transform.translate(
            offset: Offset(0, math.sin(DateTime.now().millisecondsSinceEpoch / 1000 + delay) * 15),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsApp.PraimaryMain.withOpacity(0.04),
              ),
            ),
          );
        },
      ),
    );
  }
}
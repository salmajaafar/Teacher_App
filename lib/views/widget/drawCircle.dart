import 'package:flutter/material.dart';
import 'package:parent_app/core/colorsApp.dart';
import 'dart:math' as math;
class AdvancedCreativePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = ColorsApp.PraimaryMain.withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    
    canvas.drawArc(Rect.fromCircle(center: center, radius: 160), 0, 1.5, false, paint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: 190), 2, 1.2, false, paint..strokeWidth = 1.0);
    canvas.drawArc(Rect.fromCircle(center: center, radius: 220), 4, 0.8, false, paint..color = ColorsApp.PraimaryMain.withOpacity(0.05));
    
    
    canvas.drawCircle(Offset(center.dx + 160 * math.cos(1.5), center.dy + 160 * math.sin(1.5)), 4, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

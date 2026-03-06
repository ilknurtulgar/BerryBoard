import 'package:flutter/material.dart';

class DrawingStrokeEntity {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  final String authorId;

  DrawingStrokeEntity({
    required this.points,
    required this.color,
    required this.strokeWidth,
    required this.authorId,
  });
}

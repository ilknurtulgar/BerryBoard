class StrokePoint {
  final double x;
  final double y;
  const StrokePoint(this.x, this.y);
}

class DrawingStrokeEntity {
  final List<StrokePoint> points;
  final int colorValue;
  final double strokeWidth;
  final String authorId;

  DrawingStrokeEntity({
    required this.points,
    required this.colorValue,
    required this.strokeWidth,
    required this.authorId,
  });
}

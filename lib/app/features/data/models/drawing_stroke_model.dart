import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/drawing_stroke_entity.dart';

class DrawingStrokeModel {
  final List<StrokePoint> points;
  final int colorValue;
  final double strokeWidth;
  final String authorId;
  final dynamic timestamp;

  DrawingStrokeModel({
    required this.points,
    required this.colorValue,
    required this.strokeWidth,
    required this.authorId,
    this.timestamp,
  });

  factory DrawingStrokeModel.fromMap(Map<String, dynamic> map) {
    return DrawingStrokeModel(
      points: (map['points'] as List)
          .map(
            (p) => StrokePoint(
              (p['x'] as num).toDouble(),
              (p['y'] as num).toDouble(),
            ),
          )
          .toList(),
      colorValue: map['colorValue'] as int,
      strokeWidth: (map['strokeWidth'] as num).toDouble(),
      authorId: map['authorId'] as String,
      timestamp: map['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'points': points.map((p) => {'x': p.x, 'y': p.y}).toList(),
      'colorValue': colorValue,
      'strokeWidth': strokeWidth,
      'authorId': authorId,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }

  DrawingStrokeEntity toEntity() {
    return DrawingStrokeEntity(
      points: points,
      colorValue: colorValue,
      strokeWidth: strokeWidth,
      authorId: authorId,
      timestamp: timestamp,
    );
  }
}

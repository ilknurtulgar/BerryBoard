import 'package:berry_board/app/features/domain/entities/drawing_stroke_entity.dart';
import 'package:berry_board/core/result/result.dart';

abstract class IDrawingStrokeRepository {
  Future<Result<void>> sendStroke(String roomId, DrawingStrokeEntity stroke);
  Stream<List<DrawingStrokeEntity>> watchCanvas(String roomId);
  Future<Result<void>> clearCanvas(String roomId);
}

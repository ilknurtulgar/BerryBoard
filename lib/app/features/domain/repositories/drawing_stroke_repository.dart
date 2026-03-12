import '../../../../core/result/result.dart';
import '../entities/drawing_stroke_entity.dart';

abstract class IDrawingStrokeRepository {
  Future<Result<void>> sendStroke(DrawingStrokeEntity stroke);
  Stream<Result<List<DrawingStrokeEntity>>> watchCanvas(String roomId);
  Future<Result<void>> clearCanvas(String roomId);
}

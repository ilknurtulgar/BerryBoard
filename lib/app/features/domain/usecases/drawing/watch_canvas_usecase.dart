import '../../entities/drawing_stroke_entity.dart';
import '../../repositories/drawing_stroke_repository.dart';

class WatchCanvasUsecase {
  final IDrawingStrokeRepository _repository;

  WatchCanvasUsecase(this._repository);

  Stream<List<DrawingStrokeEntity>> call(String roomId) {
    return _repository.watchCanvas(roomId);
  }
}

import '../../../../../core/result/result.dart';
import '../../repositories/drawing_stroke_repository.dart';

class ClearCanvasUsecase {
  final IDrawingStrokeRepository _repository;

  ClearCanvasUsecase(this._repository);

  Future<Result<void>> call(String roomId) {
    return _repository.clearCanvas(roomId);
  }
}

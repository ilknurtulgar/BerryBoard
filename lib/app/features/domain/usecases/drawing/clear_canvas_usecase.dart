import 'package:berry_board/app/features/domain/repositories/drawing_stroke_repository.dart';
import 'package:berry_board/core/result/result.dart';

class ClearCanvasUsecase {
  final IDrawingStrokeRepository _repository;

  ClearCanvasUsecase(this._repository);

  Future<Result<void>> call(String roomId) {
    return _repository.clearCanvas(roomId);
  }
}

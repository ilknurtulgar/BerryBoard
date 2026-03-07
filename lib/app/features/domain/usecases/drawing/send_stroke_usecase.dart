import '../../../../../core/result/result.dart';
import '../../entities/drawing_stroke_entity.dart';
import '../../repositories/drawing_stroke_repository.dart';

class SendStrokeUsecase {
  final IDrawingStrokeRepository _repository;

  SendStrokeUsecase(this._repository);

  Future<Result<void>> call(String roomId, DrawingStrokeEntity stroke) {
    return _repository.sendStroke(roomId, stroke);
  }
}

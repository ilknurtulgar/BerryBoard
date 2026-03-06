import 'package:berry_board/app/features/domain/entities/drawing_stroke_entity.dart';
import 'package:berry_board/app/features/domain/repositories/drawing_stroke_repository.dart';

import '../../../../../core/result/result.dart';

class SendStrokeUsecase {
  final IDrawingStrokeRepository _repository;

  SendStrokeUsecase(this._repository);

  Future<Result<void>> call(String roomId, DrawingStrokeEntity stroke) {
    return _repository.sendStroke(roomId, stroke);
  }
}

import 'package:berry_board/app/features/domain/repositories/match_repository.dart';
import 'package:berry_board/core/result/result.dart';

class LeaveRoomUsecase {
  final IMatchRepository _repository;

  LeaveRoomUsecase(this._repository);

  Future<Result<void>> call(String roomId) {
    return _repository.leaveRoom(roomId);
  }
}

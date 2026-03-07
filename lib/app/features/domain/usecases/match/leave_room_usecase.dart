import '../../../../../core/result/result.dart';
import '../../repositories/match_repository.dart';

class LeaveRoomUsecase {
  final IMatchRepository _repository;

  LeaveRoomUsecase(this._repository);

  Future<Result<void>> call(String roomId) {
    return _repository.leaveRoom(roomId);
  }
}

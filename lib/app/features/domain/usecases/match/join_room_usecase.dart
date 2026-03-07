import '../../../../../core/result/result.dart';
import '../../entities/match_entity.dart';
import '../../repositories/match_repository.dart';

class JoinRoomUsecase {
  final IMatchRepository _repository;

  JoinRoomUsecase(this._repository);

  Future<Result<MatchEntity>> call(String code) {
    return _repository.joinRoom(code);
  }
}

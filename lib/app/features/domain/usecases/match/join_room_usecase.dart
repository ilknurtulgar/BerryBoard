import 'package:berry_board/app/features/domain/entities/match_entity.dart';
import 'package:berry_board/app/features/domain/repositories/match_repository.dart';
import 'package:berry_board/core/result/result.dart';

class JoinRoomUsecase {
  final IMatchRepository _repository;

  JoinRoomUsecase(this._repository);

  Future<Result<MatchEntity>> call(String code) {
    return _repository.joinRoom(code);
  }
}

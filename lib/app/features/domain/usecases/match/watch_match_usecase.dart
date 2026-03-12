import 'package:berry_board/app/features/domain/repositories/match_repository.dart';

import '../../../../../core/result/result.dart';
import '../../entities/match_entity.dart';

class WatchMatchUsecase {
  final IMatchRepository _repository;

  WatchMatchUsecase(this._repository);

  Stream<Result<MatchEntity>> call(String matchCode){
    return _repository.watchMatch(matchCode);
  }
  
  
}
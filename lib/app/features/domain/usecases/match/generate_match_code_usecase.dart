import 'package:berry_board/app/features/domain/repositories/match_repository.dart';

import '../../../../../core/result/result.dart';

class GenerateMatchCodeUsecase {
  final IMatchRepository _repository;

  GenerateMatchCodeUsecase(this._repository);

  Future<Result<String>> call() {
    return _repository.generateMatchCode();
  }
}

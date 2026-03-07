import '../../../../../core/result/result.dart';
import '../../repositories/match_repository.dart';

class GenerateMatchCodeUsecase {
  final IMatchRepository _repository;

  GenerateMatchCodeUsecase(this._repository);

  Future<Result<String>> call() {
    return _repository.generateMatchCode();
  }
}

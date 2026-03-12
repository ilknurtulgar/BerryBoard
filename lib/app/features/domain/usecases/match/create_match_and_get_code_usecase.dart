import '../../../../../core/result/result.dart';
import '../../repositories/match_repository.dart';

class CreateMatchAndGetCodeUsecase {
  final IMatchRepository _repository;

  CreateMatchAndGetCodeUsecase(this._repository);

  Future<Result<String>> call() {
    return _repository.createMatchAndGetCode();
  }
}

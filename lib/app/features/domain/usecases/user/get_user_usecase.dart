import '../../../../../core/result/result.dart';
import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class GetUserUsecase {
  final IUserRepository _repository;
  GetUserUsecase(this._repository);

  Future<Result<UserEntity>> call() {
    return _repository.getUser();
  }
}

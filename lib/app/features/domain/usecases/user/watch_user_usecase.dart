import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class WatchUserUsecase {
  final IUserRepository _repository;

  WatchUserUsecase(this._repository);

  Stream<UserEntity> call() {
    return _repository.watchUser();
  }
}

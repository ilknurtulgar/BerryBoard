import 'package:berry_board/app/features/domain/entities/user_entity.dart';
import 'package:berry_board/app/features/domain/repositories/user_repository.dart';

class WatchUserUsecase {
  final IUserRepository _repository;

  WatchUserUsecase(this._repository);

  Stream<UserEntity> call() {
    return _repository.watchUser();
  }
}

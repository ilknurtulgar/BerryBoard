import 'package:berry_board/core/result/result.dart';

import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class WatchUserUsecase {
  final IUserRepository _repository;

  WatchUserUsecase(this._repository);

  Stream<Result<UserEntity>> call() {
    return _repository.watchUser();
  }
}

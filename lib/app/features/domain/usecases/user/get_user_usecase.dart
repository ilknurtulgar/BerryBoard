import 'package:berry_board/app/features/domain/entities/user_entity.dart';
import 'package:berry_board/app/features/domain/repositories/user_repository.dart';

import '../../../../../core/result/result.dart';

class GetUserUsecase {
  final IUserRepository _repository;
  GetUserUsecase(this._repository);

  Future<Result<UserEntity>> call() {
    return _repository.getUser();
  }
}

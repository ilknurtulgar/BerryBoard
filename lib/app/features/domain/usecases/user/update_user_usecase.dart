import 'package:berry_board/app/features/domain/entities/user_entity.dart';
import 'package:berry_board/app/features/domain/repositories/user_repository.dart';

import '../../../../../core/result/result.dart';

class UpdateUserUsecase {
  final IUserRepository _repository;

  UpdateUserUsecase(this._repository);

  Future<Result<void>> call(UserEntity user) async {
    return _repository.updateUser(user);
  }
}
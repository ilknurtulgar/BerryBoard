import '../../../../../core/result/result.dart';
import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class UpdateUserUsecase {
  final IUserRepository _repository;

  UpdateUserUsecase(this._repository);

  Future<Result<void>> call(UserEntity user) {
    return _repository.updateUser(user);
  }
}

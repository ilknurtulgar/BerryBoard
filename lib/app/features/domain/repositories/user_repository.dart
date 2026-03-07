import '../../../../core/result/result.dart';
import '../entities/user_entity.dart';

abstract class IUserRepository {
  Future<Result<UserEntity>> getUser();
  Stream<UserEntity> watchUser();
  Future<Result<void>> updateUser(UserEntity user);
}

import 'package:berry_board/app/features/domain/entities/user_entity.dart';

import '../../../../core/result/result.dart';

abstract class IUserRepository {
  Future<Result<UserEntity>> getUser();
  Stream<UserEntity> watchUser();
  Future<Result<void>> updateUser(UserEntity user);
}

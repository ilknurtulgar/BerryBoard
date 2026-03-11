import 'package:berry_board/app/features/data/datasources/local_storage_datasource.dart';
import 'package:berry_board/app/features/domain/repositories/user_repository.dart';

import '../../../../../core/result/result.dart';
import '../../entities/user_entity.dart';

class GetInitialRouteUseCase {
  final IUserRepository _userRepository;
  final ILocalStorageDataSource _localStorageDataSource;

  GetInitialRouteUseCase(this._userRepository, this._localStorageDataSource);

  Future<Result<UserEntity?>> call() async{
    final isSeen = _localStorageDataSource.isOnboardingSeen();

    if(!isSeen){
      return Result.success(data: null);
    }
    return await _userRepository.getUser();
  }
  
}
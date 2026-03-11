import 'package:berry_board/app/common/constants/app_strings.dart';
import 'package:berry_board/app/features/data/datasources/auth_remote_data_source.dart';
import 'package:berry_board/app/features/data/datasources/user_remote_data_source.dart';
import 'package:berry_board/app/features/data/models/user_model.dart';
import 'package:berry_board/app/features/data/repositories/base_repository.dart';
import 'package:berry_board/app/features/domain/entities/user_entity.dart';
import 'package:berry_board/app/features/domain/repositories/user_repository.dart';
import 'package:berry_board/core/result/result.dart';

class UserRepositoryImpl with BaseRepository implements IUserRepository {
  final IAuthRemoteDataSource _authRemoteDataSource;
  final IUserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl({required IAuthRemoteDataSource authDataSource, required IUserRemoteDataSource userDataSource}) :
   _authRemoteDataSource = authDataSource, _userRemoteDataSource = userDataSource;

  @override
  Future<Result<UserEntity>> getUser()async {
    return safeCall(()async {
      String? uid = _authRemoteDataSource.currentUid;
      uid ??= await _authRemoteDataSource.signInAnonymously();
      final userModel = await _userRemoteDataSource.getUser(uid);
      if(userModel != null){
        return userModel.toEntity();
      }else {
        final newUser = UserModel(uid: uid);
        await _userRemoteDataSource.saveUser(newUser);
        return newUser.toEntity();
      }
    });
  }

  @override
  Future<Result<void>> updateUser(UserEntity user) {
    return safeCall(()async {
      await _userRemoteDataSource.saveUser(UserModel.fromEntity(user));
    });
  }

  @override
  Stream<Result<UserEntity>> watchUser() {
    final uid = _authRemoteDataSource.currentUid;
    if(uid == null){
      return Stream.value(Result.error(message: AppStrings.userNotFound));
    }
    return safeStream(() =>
    _userRemoteDataSource.watchUser(uid).map((model) => model.toEntity()));
  }

  
}
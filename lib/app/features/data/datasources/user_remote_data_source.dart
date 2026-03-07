import 'package:berry_board/app/features/data/models/user_model.dart';

abstract class IUserRemoteDataSource{
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser(String uid);
  Stream<UserModel> watchUser(String uid);
}


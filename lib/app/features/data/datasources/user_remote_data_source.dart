import 'package:berry_board/app/features/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/constants/app_strings.dart';

abstract class IUserRemoteDataSource{
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser(String uid);
  Stream<UserModel> watchUser(String uid);
  Future<void> clearUserSession(String uid);
}

class UserRemoteDataSourceImpl implements IUserRemoteDataSource {
  final FirebaseFirestore _firestore;

  UserRemoteDataSourceImpl(this._firestore);

  @override
  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore.collection(AppStrings.usersPath).doc(uid).get();
    if(doc.data() != null){
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  @override
  Future<void> saveUser(UserModel user) async{
    await _firestore.collection(AppStrings.usersPath)
    .doc(user.uid).set(user.toMap(), SetOptions(merge: true));
  }

  @override
  Stream<UserModel> watchUser(String uid) {
    return _firestore.collection(AppStrings.usersPath)
    .doc(uid).snapshots().map((snapshot){
    final data = snapshot.data();
    return data != null ? UserModel.fromMap(data) : UserModel.empty(uid);
    });
  }
  
  @override
  Future<void> clearUserSession(String uid)async {
    await _firestore.collection(AppStrings.usersPath)
    .doc(uid).update({
      'partnerId': FieldValue.delete(),
      'currentRoomId': FieldValue.delete()
    });
  }
}
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRemoteDataSource {
  Future<String> signInAnonymously();
  String? get currentUid;
}

class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  final FirebaseAuth _auth;
  AuthRemoteDataSourceImpl(this._auth);

  @override
  String? get currentUid => _auth.currentUser?.uid;

  @override
  Future<String> signInAnonymously() async{
    final userCredential = await _auth.signInAnonymously();
    return userCredential.user!.uid;
  }
}
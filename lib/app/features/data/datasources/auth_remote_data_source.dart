import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRemoteDataSource {
  Future<String> singInAnonymously();
  String? get currentUid;
}

class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  String? get currentUid => _auth.currentUser?.uid;

  @override
  Future<String> singInAnonymously() async{
    final userCredential = await _auth.signInAnonymously();
    return userCredential.user!.uid;
  }
}
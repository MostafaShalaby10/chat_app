import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  Future loginRepositoryFunction({
    required String email,
    required String password,
  }) async {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

  }
}

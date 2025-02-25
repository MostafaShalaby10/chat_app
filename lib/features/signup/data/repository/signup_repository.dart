import 'package:chat_app/features/signup/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupRepository {
  late UserModel userModel ;

  Future signupRepositoryFunction({
    required String email,
    required String password,
  }) async {
    return await  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

  }

  Future saveUserDataRepositoryFunction({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) async {
    userModel = UserModel(name: name, email: email, phone: phone, uid: uId);
    await  FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel.uid)
        .set(userModel.toMap());
  }

}

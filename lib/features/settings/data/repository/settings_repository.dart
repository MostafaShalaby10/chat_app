import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/shared_preferences/shared_preferences.dart';

class SettingsRepository {
  Future getSpecificUserDataRepository() async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(SharedPrefs.getData(key: "UID"))
        .get();
  }

  Future updateNameAndPhone({
    required String name,
    required String phone,
  }) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(SharedPrefs.getData(key: "UID"))
        .update({"name": name, "phone": phone});
  }

  Future updateEmail({required String email}) async {
    return FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(email);
  }

  Future updatePassword({required String password}) async {
    return FirebaseAuth.instance.currentUser!.updatePassword(password);
  }

  Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();
  }

  Future<void> deleteAccount() async {
    return FirebaseAuth.instance.currentUser!.delete();
  }

  Future<void> deleteUserData() async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(SharedPrefs.getData(key: "UID"))
        .delete();
  }

}

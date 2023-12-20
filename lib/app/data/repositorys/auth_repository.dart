import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../model/user_model.dart';

abstract class AuthRepository extends GetxService {
  static final firebaseAuth = FirebaseAuth.instance;

  static Future<void> verifyPhoneNumber(
      {required String phoneNumber,
      required void Function(String, int?) codeSent,
      required void Function(FirebaseAuthException) verificationFailed}) async {
    try {
      await firebaseAuth.setSettings(
          appVerificationDisabledForTesting: true); // <-- here is the magic
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (err) {
      rethrow;
    }
  }

  static Future<UserCredential> signInWithCredential(
      {required PhoneAuthCredential credential}) async {
    return await firebaseAuth.signInWithCredential(credential);
  }

  static Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
      UserAccount.currentUser = null;
      Get.offAllNamed(Routes.SPLASH);
    } catch (err) {
      rethrow;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

enum SignState {
  success,
  noVerified,
  err,
}

class AuthMethods {
  final _auth = FirebaseAuth.instance;

  Future<SignState> signIn(final String email, final String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_auth.currentUser != null && _auth.currentUser!.emailVerified) {
        return SignState.success;
      } else {
        return SignState.noVerified;
      }
    } catch (e) {
      Get.snackbar('signIn err', e.toString());
      return SignState.err;
    }
  }

  Future<SignState> signUp(final String email, final String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = _auth.currentUser;
      if (user != null && user.emailVerified == false) {
        user.sendEmailVerification();
      }
      return SignState.success;
    } catch (e) {
      Get.snackbar('signUp err', e.toString());
      return SignState.err;
    }
  }

  logOut() {
    _auth.signOut();
  }
}

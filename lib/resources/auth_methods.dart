import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/models/user.dart' as models;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

enum SignState {
  success,
  noVerified,
  err,
}

class AuthMethods {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

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

  Future<SignState> signUp({
    required final String email,
    required final String password,
    required final String name,
    required final List<String> favoriteKeyword,
    required final Timestamp birthday,
    required final String profileUrl,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = _auth.currentUser;
      if (user != null && user.emailVerified == false) {
        user.sendEmailVerification();
        final tmp = _store
            .collection('email_valid')
            .doc(_auth.currentUser!.email)
            .set({'uid': _auth.currentUser!.uid});
        final modelUser = models.User(
          birthday: birthday,
          name: name,
          email: email,
          favoriteKeyword: favoriteKeyword,
          profileUrl: profileUrl,
        );
        _store.collection('users').doc(user.uid).set(modelUser.toJson());
        // _auth.verifyPhoneNumber(
        //   phoneNumber: '+82 10 3281 0807',
        //   verificationCompleted: (PhoneAuthCredential credential) {},
        //   verificationFailed: (FirebaseAuthException e) {},
        //   codeSent: (String verificationId, int? resendToken) {},
        //   codeAutoRetrievalTimeout: (String verificationId) {},
        // );
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

  Future<models.User> getUserData() async {
    if (_auth.currentUser == null) {
      throw '로그인이 안된 유저입니다.';
    }
    final userData =
        await _store.collection('users').doc(_auth.currentUser!.uid).get();
    return models.User.fromSnap(userData);
  }
}

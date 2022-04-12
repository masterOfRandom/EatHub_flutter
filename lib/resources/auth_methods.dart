import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/models/user.dart' as models;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

enum SignState {
  success,
  fail,
  userNotFound,
  wrongPassword,
  err,
}

class AuthMethods {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

  Future<bool> isNameOverlaped(final String name) async {
    try {
      final nameData =
          await _store.collection('users').where('name', isEqualTo: name).get();
      return nameData.size == 0;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> isEmailOverlaped(final String email) async {
    try {
      final emailData = await _store
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      return emailData.size != 0;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<SignState> signIn(final String email, final String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_auth.currentUser != null) {
        return SignState.success;
      } else {
        return SignState.fail;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return SignState.userNotFound;
      } else if (e.code == 'wrong-password') {
        return SignState.wrongPassword;
      } else {
        return SignState.err;
      }
    }
  }

  Future<SignState> signUp({
    required final String email,
    required final String password,
    required final String name,
    required final List<String> favoriteKeyword,
    required final Timestamp birthday,
    required final String profileUrl,
    required final bool isMale,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = _auth.currentUser;
      if (user != null) {
        final modelUser = models.User(
          birthday: birthday,
          name: name,
          email: email,
          favoriteKeyword: favoriteKeyword,
          profileUrl: profileUrl,
          isMale: isMale,
        );
        _store.collection('users').doc(user.uid).set(modelUser.toJson());
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

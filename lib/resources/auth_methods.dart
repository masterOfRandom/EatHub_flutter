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

  Future<SignState> signInWithAnonymous() async {
    try {
      await _auth.signInAnonymously();
      const user = models.User(name: '방문자');
      _store.collection('users').doc(_auth.currentUser!.uid).set(user.toJson());

      return SignState.success;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          Get.showSnackbar(GetSnackBar(
            title: e.code.toString(),
            message: '자세한 내용은 고객메일에 문의하여 주세요',
          ));
          break;
        default:
          Get.showSnackbar(const GetSnackBar(
            title: '알 수 없는 오류가 발생하였습니다',
            message: '자세한 내용은 고객메일에 문의하여 주세요',
          ));
      }
      return SignState.err;
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
    required final Gender gender,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = _auth.currentUser;
      final isMale = gender == Gender.male
          ? true
          : gender == Gender.female
              ? false
              : null;
      if (user != null) {
        final modelUser = models.User(
          birthday: birthday,
          name: name,
          email: email,
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

    final result = models.User.fromSnap(userData);
    return result;
  }

  withDrawal() async {
    if (_auth.currentUser == null) {
      throw '로그인이 안된 유저입니다.';
    }

    await _auth.currentUser!.delete();
  }
}

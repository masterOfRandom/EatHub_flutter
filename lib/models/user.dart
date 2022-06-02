import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String? name;
  final String? email;
  final Timestamp? birthday;
  final String? profileUrl;
  final bool? isMale;

  const User({
    this.name,
    this.email,
    this.birthday,
    this.profileUrl,
    this.isMale,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'birthday': birthday,
        'profile_url': profileUrl,
        'isMale': isMale,
      };

  static User fromSnap(DocumentSnapshot<Map<String, dynamic>> snap) {
    final snapshot = snap.data();
    if (snapshot == null) {
      FirebaseAuth.instance.signOut();
      throw 'DocumentSnapshot에 user가 없습니다.';
    }
    return User(
      name: snapshot['name'],
      email: snapshot['email'],
      birthday: snapshot['birthday'],
      profileUrl: snapshot['profile_url'],
      isMale: snapshot['isMale'],
    );
  }
}

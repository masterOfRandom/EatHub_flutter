import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? name;
  final String? email;
  final List? favoriteKeyword;
  final Timestamp? birthday;
  final String? profileUrl;
  final bool? isMale;

  const User({
    required this.name,
    required this.email,
    required this.favoriteKeyword,
    required this.birthday,
    required this.profileUrl,
    required this.isMale,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'favorite_keyword': favoriteKeyword,
        'birthday': birthday,
        'profile_url': profileUrl,
        'isMale': isMale,
      };

  static User fromSnap(DocumentSnapshot<Map<String, dynamic>> snap) {
    final snapshot = snap.data();
    if (snapshot == null) {
      throw 'DocumentSnapshot에 user가 없습니다.';
    }
    return User(
      name: snapshot['name'],
      email: snapshot['email'],
      favoriteKeyword: snapshot['favorite_keyword'],
      birthday: snapshot['birthday'],
      profileUrl: snapshot['profile_url'],
      isMale: snapshot['isMale'],
    );
  }
}

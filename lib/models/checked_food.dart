import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/utils/global_var.dart';

class CheckedFood {
  final String name;
  final String imageUrl;
  final CardStatus status;
  final Timestamp updateTime;

  const CheckedFood({
    required this.name,
    required this.imageUrl,
    required this.status,
    required this.updateTime,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
        'status': status,
        'updateTime': updateTime,
      };

  static CheckedFood fromSnap(DocumentSnapshot<Map<String, dynamic>> snap) {
    final snapshot = snap.data();
    if (snapshot == null) {
      throw 'DocumentSnapshot에 user가 없습니다.';
    }
    return CheckedFood(
      name: snap['name'],
      imageUrl: snap['imageUrl'],
      status: snap['status'],
      updateTime: snap['updateTime'],
    );
  }
}

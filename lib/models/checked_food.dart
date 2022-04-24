import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/utils/global_var.dart';

class CheckedFood {
  final String name;
  final String imageUrl;
  final CardStatus status;

  const CheckedFood({
    required this.name,
    required this.imageUrl,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
        'status': status.toString().split('.')[1],
      };

  static CheckedFood fromJson(dynamic data) {
    late CardStatus status;
    CardStatus.values.forEach((e) {
      if (e.toString().split('.')[1] == data['status']) {
        status = e;
        print(e);
        return;
      }
    });
    return CheckedFood(
      name: data['name'],
      imageUrl: data['imageUrl'],
      status: status,
    );
  }

  static CheckedFood fromSnap(DocumentSnapshot<Map<String, dynamic>> snap) {
    final snapshot = snap.data();
    if (snapshot == null) {
      throw 'DocumentSnapshot에 user가 없습니다.';
    }
    final statusString = snap['status'] as String;
    late CardStatus status;
    CardStatus.values.forEach((e) {
      if (e.toString().split('.')[1] == statusString) {
        status = e;

        return;
      }
    });
    return CheckedFood(
      name: snap['name'],
      imageUrl: snap['imageUrl'],
      status: status,
    );
  }
}

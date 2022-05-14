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
        'status': status.toString().split('.')[1],
        'updateTime': updateTime,
      };
  Map<String, dynamic> toSharedJson() => {
        'name': name,
        'imageUrl': imageUrl,
        'status': status.toString().split('.')[1],
        'updateTime': updateTime.toDate().toString(),
      };

  static CheckedFood fromSharedJson(dynamic data) {
    late CardStatus status;

    for (var i = 0; i < CardStatus.values.length; i++) {
      final e = CardStatus.values[i];
      if (e.toString().split('.')[1] == data['status']) {
        status = e;
        break;
      }
    }
    return CheckedFood(
      name: data['name'],
      imageUrl: data['imageUrl'],
      status: status,
      updateTime: Timestamp.fromDate(DateTime.parse(data['updateTime'])),
    );
  }

  static CheckedFood fromSnap(DocumentSnapshot<Map<String, dynamic>> snap) {
    final snapshot = snap.data();
    if (snapshot == null) {
      throw 'DocumentSnapshot에 user가 없습니다.';
    }
    final statusString = snap['status'] as String;
    late CardStatus status;

    for (var i = 0; i < CardStatus.values.length; i++) {
      final e = CardStatus.values[i];
      if (e.toString().split('.')[1] == statusString) {
        status = e;
        break;
      }
    }
    return CheckedFood(
      name: snap['name'],
      imageUrl: snap['imageUrl'],
      status: status,
      updateTime: snap['updateTime'],
    );
  }
}

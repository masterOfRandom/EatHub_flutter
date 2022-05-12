import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String? name;
  final String? imageUrl;
  final int? calories;
  final String? category;
  final List? flavors;
  final List? textures;
  final int? randomIndex;

  const Food({
    this.name,
    this.imageUrl,
    this.calories,
    this.category,
    this.flavors,
    this.textures,
    this.randomIndex,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
        'calories': calories,
        'category': category,
        'flavors': flavors,
        'textures': textures,
        'randomIndex': randomIndex,
      };

  static Food fromSnap(DocumentSnapshot<Map<String, dynamic>> snap) {
    final snapshot = snap.data();
    if (snapshot == null) {
      throw 'DocumentSnapshot에 user가 없습니다.';
    }
    return Food(
      name: snap['name'],
      imageUrl: snap['imageUrl'],
      calories: snap['calories'],
      category: snap['category'],
      flavors: snap['flavors'],
      textures: ['textures'],
      randomIndex: snap['randomIndex'],
    );
  }
}

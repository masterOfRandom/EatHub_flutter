import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/models/food.dart';

class FirestoreMethods {
  final _store = FirebaseFirestore.instance;

  Future<List<Food>> getNewRandomFoods(List<String> alreadyHadFoods) async {
    // 다 가져오는걸로 테스트
    final foodsSnap = await _store.collection('foods').get();

    final foods = foodsSnap.docs.map((e) {
      final food = e.data();
      return Food(
          name: food['name'],
          imageUrl: food['imageUrl'],
          calories: food['calories'],
          category: food['category'],
          flavors: food['flavors'],
          textures: food['textures']);
    }).toList();
    return foods;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/models/checked_food.dart';
import 'package:eathub/models/food.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirestoreMethods {
  final _user = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  final controller = Get.put(GController());

  Future<List<Food>> getNewRandomFoods(List<String> alreadyHadFoods) async {
    // 다 가져오는걸로 테스트
    final checkedFoodsName =
        controller.checkedFoods.map((element) => element.name).toList();
    checkedFoodsName.addAll(controller.foods.map((element) => element.name!));
    late QuerySnapshot<Map<String, dynamic>> foodsSnap;
    if (checkedFoodsName.isEmpty) {
      foodsSnap = await _store.collection('foods').where('name').get();
    } else {
      foodsSnap = await _store
          .collection('foods')
          .where('name', whereNotIn: checkedFoodsName)
          .get();
    }
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

  addCheckedFood(CheckedFood food) {
    if (_user.currentUser == null) {
      throw 'no user error';
    }
    final data = food.toJson();
    _store
        .collection('users')
        .doc(_user.currentUser!.uid)
        .collection('checkedFoods')
        .add(data);
  }

  Future<List<CheckedFood>> getCheckedFoods() async {
    if (_user.currentUser == null) {
      throw 'no user error';
    }
    final snap = await _store
        .collection('users')
        .doc(_user.currentUser!.uid)
        .collection('checkedFoods')
        .get();
    return snap.docs.map((e) => CheckedFood.fromSnap(e)).toList();
  }

  Future<void> removeCheckedFood(CheckedFood food) async {
    if (_user.currentUser == null) {
      throw 'no user error';
    }
    final snap = await _store
        .collection('users')
        .doc(_user.currentUser!.uid)
        .collection('checkedFoods')
        .where('name', isEqualTo: food.name)
        .get();
    snap.docs[0].reference.delete();
  }

  deleteUserData() async {
    if (_user.currentUser == null) {
      throw 'no user error';
    }
    await _store.collection('users').doc(_user.currentUser!.uid).delete();
  }
}

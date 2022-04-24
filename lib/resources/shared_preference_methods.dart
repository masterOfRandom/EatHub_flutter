import 'dart:convert';

import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/models/checked_food.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMethods {
  final controller = Get.put(GController());

  setCheckedFoods(List<CheckedFood> checkedFoods) async {
    final pref = await SharedPreferences.getInstance();

    final checkedFoodsStringList =
        checkedFoods.map((e) => jsonEncode(e.toJson())).toList();

    pref.setStringList('checkedFoods', checkedFoodsStringList);
  }

  Future<List<CheckedFood>?> getCheckedFoods() async {
    final pref = await SharedPreferences.getInstance();
    final checkedFoodsString = pref.getStringList('checkedFoods');

    if (checkedFoodsString == null) {
      return null;
    }
    final checkedFoods = checkedFoodsString
        .map((e) => CheckedFood.fromJson(jsonDecode(e)))
        .toList();
    return checkedFoods;
  }

  removeCheckedFoods() async {
    final pref = await SharedPreferences.getInstance();

    pref.remove('checkedFoods');
  }
}

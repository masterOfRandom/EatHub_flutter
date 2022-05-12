import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/models/checked_food.dart';
import 'package:eathub/models/food.dart';
import 'package:eathub/models/user.dart' as models;
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/resources/firestore_methods.dart';
import 'package:eathub/resources/shared_preference_methods.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class RandomIndex {
  int _startIndex = 0;
  DateTime _updateDate = DateTime.now();
  int _index = 0;
  final limit = 8;
  final int foodsLength;

  int getRandomStartIndex() {
    return (Random().nextDouble() * foodsLength)
        .floor();
  }

  RandomIndex({required this.foodsLength}) {
    _startIndex = getRandomStartIndex();
  }

  updateDateTime() {
    final now = DateTime.now();

    if (now.year <= _updateDate.year &&
        now.month <= _updateDate.month &&
        now.day <= _updateDate.day) {
      return;
    }
    _updateDate = now;
    _startIndex = getRandomStartIndex();
    print('startIndex = $_startIndex');
  }

  // null은 다 봤다는 뜻.
  int? getRandomIndex() {
    updateDateTime();
    print('getRandom index : $_index, foodsLength: $foodsLength');
    if (_index > foodsLength) {
      return null;
    }
    _index += limit;
    return _index % foodsLength;
  }
}

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var name = ''.obs;
  var isMale = true.obs;
  var yearOfBirth = Timestamp(0, 0).obs;

  void updateEmail({required final String email}) {
    this.email.value = email;
  }

  void updatePassword({required final String password}) {
    this.password.value = password;
  }

  void updateProfile({
    required final String name,
    required final bool isMale,
    required final Timestamp yearOfBirth,
  }) {
    this.name.value = name;
    this.isMale.value = isMale;
    this.yearOfBirth.value = yearOfBirth;
  }
}

class UserController extends GetxController {
  var user = models.User(
          name: '초기화',
          birthday: Timestamp(0, 0),
          email: '',
          profileUrl: '',
          isMale: true)
      .obs;

  void refreshUser() async {
    user.value = await AuthMethods().getUserData();
  }
}

class GController extends GetxController {
  var position = Offset.zero.obs;
  var isDragging = false.obs;
  var screenSize = Size.zero.obs;
  var angle = 0.0.obs;
  var foods = <Food>[].obs;
  var checkedFoods = <CheckedFood>[].obs;
  var statusPoint = 0.0.obs;
  var status = CardStatus.nothing.obs;
  var range = 1000.obs;
  var randomIndex = RandomIndex(foodsLength: 1).obs;
  var updating = false;

  void randomIndexInit() async {
    final foodsLength = await FirestoreMethods().getFoodsLength();
    if (foodsLength == null) {
      throw 'foodsLength 데이터를 받아오는데에 실패했습니다.';
    }
    randomIndex.value = RandomIndex(foodsLength: foodsLength);
  }

  int? getRandomIndex() {
    final result = randomIndex.value.getRandomIndex();
    if (result == null) {
      return null;
    }
    return result;
  }

  void startPosition(DragStartDetails details) {
    if (updating) {
      return;
    }
    isDragging.value = true;
  }

  void updatePosition(DragUpdateDetails details) {
    if (updating) {
      return;
    }
    position.value += details.delta;
    final x = position.value.dx;
    final y = position.value.dy;
    status.value = getStatusAndUpdateStatusPoint();

    angle.value = 40 * x / screenSize.value.width;
  }

  void endPosition() {
    if (updating) {
      return;
    }
    isDragging.value = false;

    if (statusPoint.value > 100) {
      switch (status.value) {
        case CardStatus.like:
          like();
          break;
        case CardStatus.nope:
          nope();
          break;
        case CardStatus.yet:
          yet();
          break;
        default:
          resetPosition();
      }
    } else {
      resetPosition();
    }
  }

  void resetPosition() {
    position.value = Offset.zero;
    angle.value = 0;
    statusPoint.value = 0;
    status.value = CardStatus.nothing;
  }

  CardStatus getStatusAndUpdateStatusPoint() {
    final x = position.value.dx;
    final y = position.value.dy;

    // 더 좋은 방법이 있을까?
    // 애니메이션이 느려진다면 여기를 의심하자.
    if (y > 0) {
      if (x > 0) {
        statusPoint.value = x * 2;
        return CardStatus.like;
      } else {
        statusPoint.value = (-x) * 2;
        return CardStatus.yet;
      }
    } else {
      if (x < y) {
        statusPoint.value = (y - x) * 2;
        return CardStatus.yet;
      } else {
        if (-y > x) {
          statusPoint.value = (-y - x) * 2;
          return CardStatus.nope;
        } else {
          statusPoint.value = (x + y) * 2;
          return CardStatus.like;
        }
      }
    }
  }

  void like() {
    angle.value = 20;
    position.value += Offset(screenSize.value.width * 2, 0);
    nextCard();
  }

  void nope() {
    angle.value = 0;
    position.value += Offset(0, screenSize.value.height * -2);
    nextCard();
  }

  void yet() {
    angle.value = -20;
    position.value += Offset(screenSize.value.width * -2, 0);
    nextCard();
  }

  Future nextCard() async {
    if (foods.isEmpty || updating) return;

    updating = true;
    await Future.delayed(Duration(milliseconds: 300));
    final lastFood = foods.last;
    final checkedFood = CheckedFood(
      name: lastFood.name!,
      imageUrl: lastFood.imageUrl!,
      status: status.value,
      updateTime: Timestamp.now(),
    );
    checkedFoods.add(checkedFood);
    FirestoreMethods().addCheckedFood(checkedFood);
    SharedPreferencesMethods().setCheckedFoods(checkedFoods);
    foods.removeLast();
    resetPosition();
    if (foods.length == 2) {
      addFoods();
    }
    updating = false;
  }

  void addFoods() async {
    // 음식을 랜덤으로 가져오려면 수정이 필요하다.
    final newFoods = await FirestoreMethods().getNewRandomFoods();
    foods.value = newFoods.reversed.toList() + foods;
  }

  void setScreenSize(Size size) {
    screenSize.value = size;
  }

  Future<void> initCheckedFoods() async {
    // checked 푸드 가져오기.
    final foods = await SharedPreferencesMethods().getCheckedFoods();
    if (foods == null) {
      // 로컬에 없으면 땡겨오기.
      checkedFoods.value = await FirestoreMethods().getCheckedFoods();
    } else {
      checkedFoods.value = foods;
    }
    final nowDate = Timestamp.now().toDate();
    checkedFoods.removeWhere((element) {
      final date = element.updateTime.toDate();
      if (element.status == CardStatus.yet &&
          date.year <= nowDate.year &&
          date.month <= nowDate.month &&
          date.day < nowDate.day) {
        FirestoreMethods().removeCheckedFood(element);
        return true;
      } else {
        return false;
      }
    });
    SharedPreferencesMethods().updateCheckedFoods(checkedFoods);
  }

  Future<void> removeCheckedFoods() async {
    await SharedPreferencesMethods().removeCheckedFoods();
    checkedFoods.value = [];
  }

  void removeFoods() {
    foods.value = [];
  }

  void setRange(int newRange) {
    range.value = newRange;
  }

  deleteCheckedFood(CheckedFood food) async {
    await FirestoreMethods().removeCheckedFood(food);
    checkedFoods.remove(food);
  }

  updateCheckedFoods() async {
    await SharedPreferencesMethods().removeCheckedFoods();
    await SharedPreferencesMethods().updateCheckedFoods(checkedFoods);
  }
}

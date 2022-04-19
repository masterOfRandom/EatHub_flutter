import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/models/food.dart';
import 'package:eathub/models/user.dart' as models;
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/resources/firestore_methods.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Sex {
  male,
  female,
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
          name: '',
          birthday: Timestamp(0, 0),
          email: '',
          favoriteKeyword: [''],
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
  var statusPoint = 0.0.obs;
  var status = CardStatus.nothing.obs;

  var updating = false;

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

    if (statusPoint.value > 60) {
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
        statusPoint.value = x;
        return CardStatus.like;
      } else {
        statusPoint.value = -x;
        return CardStatus.yet;
      }
    } else {
      if (x < y) {
        statusPoint.value = y - x;
        return CardStatus.yet;
      } else {
        if (-y > x) {
          statusPoint.value = -y - x;
          return CardStatus.nope;
        } else {
          statusPoint.value = x + y;
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
    await Future.delayed(Duration(milliseconds: 200));
    foods.removeLast();
    print(foods.length);
    resetPosition();
    if (foods.length == 2) {
      addFoods();
    }
    updating = false;
  }

  void addFoods() async {
    // 음식을 랜덤으로 가져오려면 수정이 필요하다.
    final newFoods = await FirestoreMethods().getNewRandomFoods(['food']);
    foods.value = newFoods.reversed.toList() + foods;
  }

  void setScreenSize(Size size) {
    screenSize.value = size;
  }
}

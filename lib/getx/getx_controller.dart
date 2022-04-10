import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/models/user.dart' as models;
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var user = models.User(
          name: '',
          birthday: Timestamp(0, 0),
          email: '',
          favoriteKeyword: [''],
          profileUrl: '')
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
  var imageUrls = <String>[].obs;
  var statusPoint = 0.0.obs;
  var status = CardStatus.nothing.obs;

  void startPosition(DragStartDetails details) {
    isDragging.value = true;
  }

  void updatePosition(DragUpdateDetails details) {
    position.value += details.delta;
    final x = position.value.dx;
    final y = position.value.dy;
    status.value = getStatusAndUpdateStatusPoint();

    angle.value = 40 * x / screenSize.value.width;
  }

  void endPosition() {
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
    if (imageUrls.isEmpty) return;

    await Future.delayed(Duration(milliseconds: 200));
    imageUrls.removeLast();
    resetPosition();
  }

  void resetUsers() {
    imageUrls.value = <String>[
      'https://img1.kakaocdn.net/cthumb/local/R0x420/?fname=http%3A%2F%2Ft1.daumcdn.net%2Fplace%2FCF25058968C0493096142CA35FC89EFC',
      'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20220220_263%2F1645354113369xzzBW_JPEG%2Fupload_3d6f35dbf92c77cee0c3f911b6cd3645.jpeg',
      'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20220322_113%2F1647954093603xlgUO_JPEG%2Fupload_2eb34d32de6381efe8b2c2acde455ef3.jpg',
      'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20220320_14%2F16477769214678csvB_JPEG%2Fupload_fca1f7a89e4baacf8f0eb200cc45f4fb.jpeg',
      'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20220323_104%2F1648026669604abgGH_JPEG%2Fupload_620d47847e212b5eb21072fb91dc9a00.jpg',
      'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20220220_29%2F1645334336147IFgpJ_JPEG%2Fupload_35eddb097619a344b7e5593deb6f4838.jpeg',
      'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20220214_182%2F1644821957660AoUWW_JPEG%2Fupload_6ea743f055f5bdc06fd00b8407c0a49f.jpg',
      'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20211205_197%2F1638701820259A7VOe_JPEG%2Fupload_2a6644e831c0975fc308b135e4fb281d.jpeg',
      'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20220127_157%2F16432721394834rkCr_JPEG%2Fupload_c820a17c54a53775fc56a1f3d42f3d4e.jpg',
      'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20220314_78%2F1647233279516afaso_JPEG%2Fupload_c1c19a6bea26b1795a5871d101476c11.jpeg',
      'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20220326_132%2F1648284109890clh1g_JPEG%2Fupload_3756a5d1d658bb9498ce1c83455ea6a2.jpeg',
      'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20220106_74%2F16414668482766EcCl_JPEG%2Fupload_e4a79787ae6edf189a338f942a1b90e7.jpeg',
      'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20211129_6%2F1638117062735Ttf7C_JPEG%2Fupload_35728b53a04a08eccee61bb717566dcc.jpeg',
      'https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20220220_233%2F164535712940788D6z_JPEG%2Fupload_7e029521127db0675764585122e8d9e5.jpeg',
    ].reversed.toList();
  }

  void setScreenSize(Size size) {
    screenSize.value = size;
  }
}

import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/resources/firestore_methods.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        '로그아웃',
        style: TextStyle(color: primaryRedColor),
      ),
      content: const Text('로그아웃 하시게 되면 그동안\n픽했던 데이터는 사라집니다 🥲'),
      actions: [
        CupertinoDialogAction(
          textStyle: const TextStyle(
              color: grayScaleGray3, fontWeight: FontWeight.w700),
          onPressed: () => Get.back(),
          child: const Text('취소'),
        ),
        CupertinoDialogAction(
          textStyle: const TextStyle(color: grayScaleGray3),
          onPressed: () {
            final controller = Get.put(GController());
            controller.removeCheckedFoods();
            controller.removeFoods();
            FirestoreMethods().deleteUserData();
            AuthMethods().logOut();
            Get.back();
          },
          child: const Text('로그아웃'),
        ),
      ],
    );
  }
}

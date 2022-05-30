import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/resources/firestore_methods.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WithdrawalDialog extends StatelessWidget {
  final controller = Get.put(GController());

  WithdrawalDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        '회원탈퇴',
        style: TextStyle(color: primaryRedColor),
      ),
      content: const Text('정말로 탈퇴 하실건가요..?😢\n탈퇴하시게 되면 그동안\n픽했던 데이터는 사라집니다',
          style: TextStyle(color: grayScaleGray2)),
      actions: [
        CupertinoDialogAction(
          textStyle: const TextStyle(
              color: grayScaleGray3, fontWeight: FontWeight.w700),
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        CupertinoDialogAction(
          textStyle: const TextStyle(color: grayScaleGray3),
          onPressed: () {
            // 회원탈퇴
            FirestoreMethods().deleteUserData();
            AuthMethods().withDrawal();
            controller.removeCheckedFoods();
            controller.removeFoods();
            Get.back();
            Get.back();
          },
          child: const Text('회원탈퇴'),
        ),
      ],
    );
  }
}

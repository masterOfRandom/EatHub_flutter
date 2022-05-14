import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
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
      content: const Text('정말로 로그아웃 하시겠어요?'),
      actions: [
        CupertinoDialogAction(
          child: const Text('취소'),
          textStyle: const TextStyle(color: grayScaleGray3),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          child: const Text('로그아웃'),
          textStyle: const TextStyle(color: primaryRedColor),
          onPressed: () {
            final controller = Get.put(GController());
            controller.removeCheckedFoods();
            controller.removeFoods();
            AuthMethods().logOut();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

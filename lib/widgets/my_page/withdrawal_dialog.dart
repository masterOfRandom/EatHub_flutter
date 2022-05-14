import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/resources/firestore_methods.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/cupertino.dart';

class WithdrawalDialog extends StatelessWidget {
  const WithdrawalDialog({Key? key}) : super(key: key);

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
          child: const Text('취소'),
          textStyle: const TextStyle(
              color: grayScaleGray3, fontWeight: FontWeight.w700),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          child: const Text('회원탈퇴'),
          textStyle: const TextStyle(color: grayScaleGray3),
          onPressed: () async {
            // 회원탈퇴
            await FirestoreMethods().deleteUserData();
            await AuthMethods().withDrawal();
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

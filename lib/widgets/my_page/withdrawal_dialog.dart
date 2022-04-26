import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawalDialog extends StatelessWidget {
  const WithdrawalDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        '회원탈퇴',
        style: TextStyle(color: primaryRedColor),
      ),
      content:
          Text('정말로 탈퇴 하실건가요..?😢', style: TextStyle(color: grayScaleGray2)),
      actions: [
        CupertinoDialogAction(
          child: Text('취소'),
          textStyle:
              TextStyle(color: grayScaleGray3, fontWeight: FontWeight.w700),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          child: Text('회원탈퇴'),
          textStyle: TextStyle(color: grayScaleGray3),
          onPressed: () {
            // 회원탈퇴
            print('회원탈퇴');
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

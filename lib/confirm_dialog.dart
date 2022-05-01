import 'package:eathub/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  const ConfirmDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: primaryRedColor,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Text(
        content,
        style: TextStyle(
          color: grayScaleGray2,
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Get.back();
          },
          child: Text(
            '확인',
            style: TextStyle(
                color: grayScaleGray3,
                fontWeight: FontWeight.w700,
                fontSize: 16),
          ),
        ),
      ],
    );
  }
}

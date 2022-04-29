import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/screens/my_page_screens/introduce_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/widgets/my_page/logout_dialog.dart';
import 'package:eathub/widgets/my_page/set_range_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPageList extends StatefulWidget {
  const MyPageList({Key? key}) : super(key: key);

  @override
  State<MyPageList> createState() => _SettingListState();
}

class _SettingListState extends State<MyPageList> {
  Widget _myPageTile({
    required IconData lead,
    required String text,
    required VoidCallback callback,
  }) {
    return ListTile(
      leading: Icon(lead),
      title: Text(text),
      trailing: Icon(
        Icons.chevron_right,
        color: grayScaleGray4,
      ),
      onTap: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _myPageTile(
            lead: Icons.gps_fixed,
            text: '주변 식당 범위 설정',
            callback: () {
              showCupertinoDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (_) {
                    return const SetRangeDialog();
                  });
            }),
        Divider(),
        _myPageTile(
            lead: Icons.gps_fixed,
            text: '테이블픽 소개',
            callback: () {
              Get.to(IntroduceScreen());
            }),
        Divider(),
        _myPageTile(
            lead: Icons.gps_fixed,
            text: '로그아웃',
            callback: () {
              showCupertinoDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (_) {
                    return const LogoutDialog();
                  });
            }),
        Divider(),
      ],
    );
  }
}

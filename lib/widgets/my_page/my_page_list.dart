import 'package:eathub/widgets/confirm_dialog.dart';
import 'package:eathub/presentation/table_pick_icons.dart';
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
      trailing: const Icon(
        TablePick.navigate_next,
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
            lead: TablePick.my_location,
            text: '주변 식당 범위 설정',
            callback: () {
              showCupertinoDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (_) {
                    return const SetRangeDialog();
                  });
            }),
        const Divider(),
        _myPageTile(
            lead: TablePick.card,
            text: '테이블픽 소개',
            callback: () {
              Get.to(const IntroduceScreen());
            }),
        const Divider(),
        _myPageTile(
            lead: TablePick.help,
            text: '고객 문의',
            callback: () {
              showCupertinoDialog(
                  context: context,
                  builder: (_) {
                    return const ConfirmDialog(
                      title: '이메일 문의',
                      content: 'tablepick2022@gmail.com로\n문의해주세요',
                    );
                  });
            }),
        const Divider(),
        _myPageTile(
            lead: TablePick.logout,
            text: '로그아웃',
            callback: () {
              showCupertinoDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (_) {
                    return const LogoutDialog();
                  });
            }),
        const Divider(),
      ],
    );
  }
}

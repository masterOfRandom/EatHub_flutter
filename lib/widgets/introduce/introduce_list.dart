import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/screens/my_page_screens/introduce_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/widgets/my_page/logout_dialog.dart';
import 'package:eathub/widgets/my_page/set_range_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroduceList extends StatefulWidget {
  const IntroduceList({Key? key}) : super(key: key);

  @override
  State<IntroduceList> createState() => _SettingListState();
}

class _SettingListState extends State<IntroduceList> {
  Widget _myPageTile({
    required IconData lead,
    required String text,
    required VoidCallback callback,
  }) {
    return ListTile(
      leading: Icon(lead),
      title: Text(text),
      trailing: Icon(
        Icons.expand_more,
        color: grayScaleGray4,
      ),
      onTap: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _myPageTile(lead: Icons.gps_fixed, text: '고객 문의', callback: () {}),
        Divider(),
        _myPageTile(lead: Icons.gps_fixed, text: '고객 문의', callback: () {}),
        Divider(),
        _myPageTile(lead: Icons.gps_fixed, text: '고객 문의', callback: () {}),
        Divider(),
      ],
    );
  }
}

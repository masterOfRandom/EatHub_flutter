import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/screens/my_page_screens/introduce_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:eathub/widgets/my_page/logout_dialog.dart';
import 'package:eathub/widgets/my_page/set_range_dialog.dart';
import 'package:eathub/widgets/my_page/withdrawal_dialog.dart';
import 'package:eathub/widgets/table_pick_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroduceList extends StatefulWidget {
  const IntroduceList({Key? key}) : super(key: key);

  @override
  State<IntroduceList> createState() => _SettingListState();
}

class _SettingListState extends State<IntroduceList> {
  bool isMore = false;
  bool visible = false;

  Widget _myPageTile({
    required IconData lead,
    required String text,
    required VoidCallback callback,
  }) {
    return ListTile(
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
    return SingleChildScrollView(
      child: Column(
        children: [
          _myPageTile(
              lead: Icons.gps_fixed,
              text: '이용약관',
              callback: () async {
                await launch(termsOfServiceUrl);
              }),
          const Divider(),
          _myPageTile(
              lead: Icons.gps_fixed,
              text: '개인 정보 처리 방침',
              callback: () async {
                await launch(termsOfPrivacyPolicyUrl);
              }),
          const Divider(),
          _myPageTile(
              lead: Icons.gps_fixed,
              text: '위치 기반 서비스 약관',
              callback: () async {
                await launch(termsOfLocationPolicyUrl);
              }),
          const Divider(),
          _myPageTile(
              lead: Icons.gps_fixed,
              text: '더보기',
              callback: () {
                if (isMore) {
                  visible = false;
                }
                isMore = !isMore;
                setState(() {});
              }),
          AnimatedContainer(
            decoration: isMore
                ? BoxDecoration(
                    border: Border.all(color: grayScaleGray5),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10)))
                : BoxDecoration(),
            duration: Duration(milliseconds: 500),
            height: isMore ? 260 : 0,
            curve: Curves.ease,
            onEnd: () {
              isMore ? visible = true : visible = false;
              setState(() {});
            },
            child: visible
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('버전정보',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20)),
                        Text(
                          '현재버전 1.1.0',
                        ),
                        Text(
                          '최신버전 1.2.0',
                          style: TextStyle(color: primaryRedColor),
                        ),
                        SizedBox(height: 16),
                        TablePickElevatedButton(
                            isLoading: false, text: '최신버전으로 업데이트'),
                        SizedBox(height: 32),
                        TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => WithdrawalDialog());
                          },
                          child: Text('회원탈퇴',
                              style: TextStyle(
                                  color: grayScaleGray3, fontSize: 20)),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

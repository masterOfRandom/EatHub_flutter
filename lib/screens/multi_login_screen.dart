import 'package:eathub/screens/login_screens/login_email_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Introduce extends StatelessWidget {
  const Introduce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '안녕하세요,',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SvgPicture.asset(
              'assets/table_pick_logo.svg',
              height: 28,
            ),
            SizedBox(width: 4),
            Text(
              '입니다.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SizedBox(height: 24),
        Text(
          '3초만에 로그인하고',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: grayScaleGray2),
        ),
        SizedBox(height: 4),
        Text(
          '메뉴를 추천받아보세요.',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: grayScaleGray2),
        ),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final Icon? icon;
  final String text;
  final VoidCallback? callback;
  const LoginButton({
    Key? key,
    this.color = Colors.grey,
    this.icon,
    required this.text,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            icon == null
                ? Container()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: icon!),
            Text(text),
          ],
        ),
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
      ),
    );
  }
}

class MultiLoginScreen extends StatelessWidget {
  const MultiLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundGrayColor,
        shadowColor: mobileBackgroundGrayColor,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextButton(
              onPressed: () => print('고객문의'),
              child: Text(
                '고객문의',
                style: TextStyle(
                    fontSize: 16,
                    color: grayScaleGray2,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: mobileBackgroundGrayColor,
        alignment: Alignment.center,
        padding: EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Introduce(),
                Expanded(child: Container()),
                SizedBox(height: 68),
                // LoginButton(
                //   text: '카카오 로그인',
                //   icon: Icon(Icons.message),
                //   callback: () => print('카카오~'),
                // ),
                SizedBox(
                  height: 16,
                ),
                LoginButton(
                  text: '이메일로 시작하기',
                  icon: Icon(Icons.mail),
                  callback: () => Get.to(LoginEmailScreen()),
                ),
              ]),
        ),
      ),
    );
  }
}

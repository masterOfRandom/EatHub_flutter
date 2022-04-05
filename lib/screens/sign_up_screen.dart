import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/main.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final idController = TextEditingController();
  final pwController = TextEditingController();
  final nameController = TextEditingController();

  bool isSignUpLoading = false;

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              child: TextField(
                decoration: InputDecoration(hintText: '이메일'),
                controller: idController,
              ),
            ),
            Container(
              height: 50,
              child: TextField(
                decoration: InputDecoration(hintText: '비밀번호'),
                controller: pwController,
              ),
            ),
            Container(
              height: 50,
              child: TextField(
                decoration: InputDecoration(hintText: '이름'),
                controller: nameController,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                isSignUpLoading = true;

                final result = await AuthMethods().signUp(
                    email: idController.text,
                    password: pwController.text,
                    name: '정민재',
                    favoriteKeyword: ['친절', '깨끗'],
                    birthday: Timestamp.fromDate(DateTime.parse('1994-08-07')),
                    profileUrl:
                        'https://www.attendit.net/images/easyblog_shared/July_2018/7-4-18/b2ap3_large_totw_network_profile_400.jpg');

                if (result == SignState.err) {
                  setState(() {
                    isSignUpLoading = false;
                  });
                } else if (result == SignState.success) {
                  Get.snackbar('회원가입 완료!!', '이메일 인증을 완료하고 EatHub를 이용해보세요!!');
                  Navigator.pop(context);
                } else {
                  print('else다!!!!!!!!!!!!!!!!!!');
                }
                setState(() {});
              },
              child: Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}
